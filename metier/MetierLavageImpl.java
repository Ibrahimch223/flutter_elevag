package metier;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import entities.Agence;
import entities.Bus;
import entities.Operation;





/**
 * @author Khaoula Jridi
 *  DEV 2020 --EcoClean Tunisie
 */
public class MetierLavageImpl implements IMetierLavage 
{

	@Override
	public void addOperation(Operation op,Bus bus,Agence agence) {
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("insert into operation(nomOperation,dateOperation,prixOperation) values (?,?,?);"
					+ "insert  into bus(matricule,typeVehicule,codeAgence) values (?,?, (select codeAgence from agence where agence.nomAgence=?));"
					+ "insert into operationbus(codeoperation,matricule) values (LAST_INSERT_ID(),?);"  
					
				
							);
			ps.setString(1,op.getNomOperation() );
			java.util.Date date = op.getDateOperation();
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			ps.setDate(2,sqlDate);
			ps.setDouble(3,op.getPrixOperation() );
			ps.setString(4,bus.getMatricule());
			ps.setString(5, bus.getType());
			ps.setString(6,agence.getNomAgence());
			ps.setString(7, bus.getMatricule());
			System.out.println(ps);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

	@Override
	public Collection<Operation> getOperationByBus(String matricule)
	{
		Collection<Operation> ops = new ArrayList<Operation>();
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select operation.*,operationbus.codeOperation,bus.matricule " + 
							"			 from operation,operationbus,bus"
							+ " where operation.codeOperation=operationbus.codeOperation"
							+ " and operationbus.matricule=bus.matricule"
							+ " and bus.matricule like ?");
			
			ps.setString(1,"%"+matricule+"%");
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Operation op = new Operation();
				op.setNomOperation(rs.getString("nomOperation"));
				op.setDateOperation(rs.getDate("dateOperation"));
				op.setPrixOperation(rs.getDouble("prixOperation"));
				ops.add(op);
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ops;
	}

	@Override
	public void addAgence(Agence agence)
	{
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("insert into agence(nomAgence) value(?)");
			ps.setString(1,agence.getNomAgence());
			
			System.out.println(ps);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public Collection<Operation> getOperationByDate(java.sql.Date date) {
		Collection<Operation> ops = new ArrayList<Operation>();
		Bus b=null;
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select * from operation "
							+ "where dateOperation=?"
						);
			
			ps.setDate(1,(Date) date);
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Operation op = new Operation();
				op.setCodeOperation(rs.getInt("codeOperation"));
				op.setNomOperation(rs.getString("nomOperation"));
				op.setDateOperation(rs.getDate("dateOperation"));
				op.setPrixOperation(rs.getDouble("prixOperation"));
				ops.add(op);
				
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ops;
		
	}

	@Override
	public Bus getBusByOperation(int codeOperation, Date dateOperation) {
	
		Bus b = null;
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select * from bus,operationbus,operation where"
							+ " bus.matricule=operationbus.matricule"
							+ " and operation.codeOperation= operationbus.codeOperation"
							+ " and operation.codeOperation=?"
							+ " and operation.dateOperation=?");
			ps.setInt(1,codeOperation);
			ps.setDate(2, dateOperation);
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
		
			if(rs.next()){
				b=new Bus();
				b.setMatricule(rs.getString("matricule"));
				b.setType(rs.getString("typeVehicule"));
				//b.getAgence().setNomAgence((rs.getString("nomAgence")));
								
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return b;	
		
		
	}

	@Override
	public Agence getAgenceByMatricule(String matricule) {

		Agence a = null;
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select * from bus,agence where"
							+ " bus.codeAgence=Agence.codeAgence"
							+ " and bus.matricule like ?");
			ps.setString(1,matricule);
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
		
			if(rs.next()){
				a=new Agence();
				a.setCodeAgence(rs.getInt("codeAgence"));
				a.setNomAgence(rs.getString("nomAgence"));
				
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return a;
	}

	@Override
	public Collection<Agence> getAllAgence() {
		Collection<Agence> agences = new ArrayList<Agence>();
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select *from agence");
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Agence ag = new Agence();
			    ag.setNomAgence(rs.getString("nomAgence"));
				agences.add(ag);
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return agences;
		
	}

	@Override
	public String getBusByOperation(int codeOperation) {
		Bus b=null;
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select * from bus,operationbus,operation where"
							+ " bus.matricule=operationbus.matricule"
							+ " and operation.codeOperation= operationbus.codeOperation"
							+ " and operation.codeOperation=?"
							);
			ps.setInt(1,codeOperation);
			
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
		
			if(rs.next()){
				b=new Bus();
				b.setMatricule(rs.getString("matricule"));
				b.setType(rs.getString("typeVehicule"));
				//b.getAgence().setNomAgence((rs.getString("nomAgence")));
								
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return b.getMatricule();	
		
	}

	@Override
	public Collection<Bus> getAllBusByOperation(Date dateOperation) {
		Collection <Bus> bus = new ArrayList<Bus>();
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select bus.matricule,bus.typeVehicule from bus,operationbus,operation where"
							+ " bus.matricule=operationbus.matricule"
							+ " and operation.codeOperation= operationbus.codeOperation"
							+ " and operation.dateOperation=?");
			ps.setDate(1,dateOperation);
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
		
			while(rs.next()){
				Bus b=new Bus();
				b.setMatricule(rs.getString("matricule"));
			    b.setType(rs.getString("typeVehicule"));
			    bus.add(b);
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bus;	
		
		
	}

	@Override
	public List<Object> getAllByDateOperation(Date dateOperation) {
		List <Object> lstObj = new ArrayList<Object>();
		Connection conn=SingletonConnection.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement
					("select * from bus,operationbus,operation,agence where"
							+ " agence.codeAgence=bus.codeAgence"
							+ " and bus.matricule=operationbus.matricule"
							+ " and operation.codeOperation= operationbus.codeOperation"
							+ " and operation.dateOperation=?");
			ps.setDate(1,dateOperation);
			System.out.println(ps);
			ResultSet rs = ps.executeQuery();
		
			while(rs.next()){
				
				Object obj=new Agence();
				//Object ob = new Bus();
				Object o = new Operation();
				
				((Agence) obj).setNomAgence(rs.getString("nomAgence"));
				
				((Agence) obj).setMatricule(rs.getString("matricule"));
			    ((Agence) obj).setType(rs.getString("typeVehicule"));
			   
			    ((Agence) obj).setNomOperation(rs.getString("nomOperation"));
			    ((Agence) obj).setPrixOperation(rs.getDouble("prixOperation"));
						
				lstObj.add(obj);
				
			    
			 		    
			    
			}
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lstObj;	
		
		
	}


}
