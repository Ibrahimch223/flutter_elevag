package metier;

import java.util.Collection;
import java.util.List;
import java.sql.Date;

import entities.Agence;
import entities.Bus;
import entities.Operation;

public interface IMetierLavage
{

	public void addOperation(Operation op,Bus bus,Agence agence);
	public Collection<Operation> getOperationByBus(String matricule);
	public void addAgence(Agence agence);
	public Collection<Operation> getOperationByDate(Date date);
	public Bus getBusByOperation(int codeOperation, Date dateOperation);
	public Agence getAgenceByMatricule(String matricule);
	public Collection<Agence> getAllAgence();
	public String getBusByOperation(int codeOperation);
	
	public Collection<Bus> getAllBusByOperation(Date dateOperation);
	public List<Object> getAllByDateOperation(Date dateOperation);
}
