using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1.Dashboard
{
    public class Overalls_BusinessLayer
    {
        /* Class Field Declaration Area */
        decimal result = 0;
        Overalls_DataLayer obj = null;

        public Overalls_BusinessLayer()
        {
            this.obj = new Overalls_DataLayer();
        }

        public decimal getHospitalYTDOverall(string hospital)
        {
            string query = "Declare @hospital [int] " +
                           "Set @hospital = " + hospital +
                           "Select	Cast(Cast(Sum( Case When w.WOcerrada= 1 And mpi.idMP Is Null Then 1 Else 0 End) + " +
			                        "Sum( Case When w.WOcerrada= 1 And mpi.idMP is not null And mpi.idRazon <> 5 Then 1 Else 0 End) As Numeric) / " +
			                        "Cast(Count(w.id) AS Numeric) * 100 As Decimal (12,2)) As 'Percentage' " +

	                        "From	Equipamiento As e Inner Join " +
			                        "WorkOrder As w On e.id = w.idEquipamiento Inner Join " +
			                        "Hospital As h On w.idhospital = h.idinstitucion Inner Join " +
			                        "MP On w.idMP = mp.id Full Join " +
			                        "MPIncompleto As mpi On mp.id = mpi.idMP " +
								
	                        "Where	w.idTipoWorkOrder = 30 And IsPreventiveMaintenance = 1 And (@hospital = 0 Or w.idHospital = @hospital) And " +
			                        "Month(w.FechaRequerida) Between Month(DateAdd(d, -DatePart(dy, GetDate() -1), GetDate())) And Month(DateAdd(d, 365 - DatePart(dy, GetDate()), GetDate())) And " +
			                        "Year(w.FechaRequerida) = Year(GetDate()) ";

            this.result = obj.returnOverall(query);
            return this.result;
        }

        public decimal getOpenedPMs(int woType)
        {
            string query =  "Select	Count(w.id) " +
                            "From	workorder w Inner Join " +
		                            "equipamiento e On w.idEquipamiento = e.id Inner Join " +
		                            "hospital h On w.idHospital = h.idInstitucion " +

                            "Where	idtipoworkorderprimario = " + woType + " And Month(w.FechaRecibida) = Month(GetDate()) And Year(w.FechaRecibida) = Year(GetDate()) " +
		                            " And wocerrada = 0 And e.estado = 1 And h.eliminado = 0 And e.idFrecuencia <> 36 And h.pm = 1 ";
            this.result = obj.returnOverall(query);
            return this.result;
        }

        public decimal getPMComplianceOverall(string hospital)
        {
            string query = "Declare @hospital [int] " +
                            "Set @hospital = " + hospital +
                            " Select		isNull(Cast(Cast(Sum( Case When w.idTipoWorkOrder = 30 And w.WOcerrada= 1 And mpi.idMP Is Null And Month(w.FechaRequerida) = Month(GetDate()) And Year(w.FechaRequerida) = Year(GetDate()) Then 1 Else 0 End) + " +
                                        "Sum( Case When w.idTipoWorkOrder = 30 And w.WOcerrada= 1 And mpi.idMP is not null And mpi.idRazon <> 5 And Month(w.FechaRequerida) = Month(GetDate()) And Year(w.FechaRequerida) = Year(GetDate()) Then 1 Else 0 End) As Numeric) / " +
                                        "Case When Cast(Sum( Case When w.idTipoWorkOrder = 30 And Month(w.FechaRequerida) = Month(GetDate()) And Year(w.FechaRequerida) = Year(GetDate()) Then 1 Else 0 End ) As Numeric)= 0 Then Null Else " +
                                        "Cast(Sum( Case When w.idTipoWorkOrder = 30 And Month(w.FechaRequerida) = Month(GetDate()) And Year(w.FechaRequerida) = Year(GetDate()) Then 1 Else 0 End ) As Numeric) End * 100 As Decimal (12,2)), 0) As 'Percentage_PMs' " +

                            "From		Equipamiento As e Inner Join " +
                                        "WorkOrder As w On e.id = w.idEquipamiento Inner Join " +
                                        "Hospital As h On w.idhospital = h.idinstitucion Inner Join " +
                                        "MP On w.idMP = mp.id Full Join " +
                                        "MPIncompleto As mpi On mp.id = mpi.idMP " +

                            "Where		h.Eliminado = 0 And e.Eliminado = 0 And h.pm = 1 And IsPreventiveMaintenance = 1 And (@hospital = 0 Or w.idHospital = @hospital)";
                            
            this.result = obj.returnOverall(query);
            return this.result;
        }

        public decimal getYTDPrioritiesCompliance(string hospital)
        {
            string query = "Declare @hospital [int] " +
                            "Set @hospital = " + hospital +
                            "Select		Cast(Cast(Sum( Case When w.idTipoWorkOrder = 31 And w.wocerrada = 1  And Month(w.FechaRecibida) = Month(GetDate()) And Year(w.FechaRecibida) = Year(GetDate()) Then 1 Else 0 End ) As Numeric) / " +
                                        "Cast(Sum( Case When w.idTipoWorkOrder = 31 And w.wocerrada = 0 Then 1 Else 0 End ) As Numeric) * 100 As Decimal(12,2)) As 'Percentage' " +

                            "From		Equipamiento As e Inner Join " +
                                        "WorkOrder As w On e.id = w.idEquipamiento Inner Join " +
                                        "Hospital As h On w.idhospital = h.idinstitucion Inner Join " +
                                        "MP On w.idMP = mp.id Full Join " +
                                        "MPIncompleto As mpi On mp.id = mpi.idMP " +

                            "Where		h.Eliminado = 0 And e.Eliminado = 0 And IsPreventiveMaintenance = 1 And h.pm = 1 And ( @hospital = 0 Or w.idHospital = @hospital )";
            this.result = obj.returnOverall(query);
            return this.result;
        }

        public decimal getUserCompliance(int uid)
        {
            string query = "Select  isNull(Cast(Cast(Sum( Case When w.WOcerrada= 1 And mpi.idMP Is Null Then 1 Else 0 End) + " +
                                    "Sum( Case When w.WOcerrada= 1 And mpi.idMP is not null And mpi.idRazon <> 5 Then 1 Else 0 End) As Numeric) / " +
                                    "Cast(Count(bw.woid) AS Numeric) * 100 As Decimal (12,2)), 0) As 'Percentage' " +

                            "From  BMET_WO AS bw Inner Join " +
                                    "WorkOrder As w On bw.WOID = w.ID Inner Join " +
                                    "Equipamiento As e On w.idEquipamiento = e.ID Inner Join  " +
                                    "Hospital_ByLocation As h On w.IDHospital = h.id Inner Join " +
                                    "MP On w.idMP = mp.id Full Join " +
                                    "MPIncompleto As mpi On mp.id = mpi.idMP " +

                            "Where w.idTipoWorkOrder = 30 And IsPreventiveMaintenance = 1 And e.Estado = 1 And " +
                                    "Month(bw.RequiredDate) = Month(GetDate()) And Year(bw.RequiredDate) = Year(GetDate()) And bw.UserID = " + uid.ToString();

            
            this.result = obj.returnOverall(query);
            return this.result;
        }

        public decimal getPendingClose()
        {
            string query = "Select Count(id) As 'Counter' " +
                           "From	WorkOrder " +
                           "Where	ParaCerrar = 1 And WOCerrada = 0 and IsPreventiveMaintenance = 0 ";

            this.result = obj.returnOverall(query);
            return this.result;
        }

        public decimal getOpenedWO()
        {
            string query = "Select	Count(id) As 'Count' " +
                            "From	workorder w Inner Join " +
		                            "Hospital h On w.idHospital = h.idInstitucion " +
                            "Where	w.isPreventiveMaintenance = 0 And w.WOCerrada = 0 And ParaCerrar = 0 And h.Eliminado = 0";

            this.result = obj.returnOverall(query);
            return this.result;
        }
    }
}
