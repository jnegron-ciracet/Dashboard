using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary.Entity;
using ClassLibrary.Data_Access_Layer;

namespace ClassLibrary.Business_Logic_Layer
{
    public class Location_Bll
    {
        public List<Location_Entity> getUser()
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_User();

            return list;
        }

        public List<Location_Entity> getAllUsers()
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_AllUsers();

            return list;
        }

        public List<Location_Entity> getAllBMETUsers()
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_AllBMETUsers();

            return list;
        }

        public List<Location_Entity> getUserHospital(int uid)
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_UserHospital(uid);

            return list;
        }

        public List<Location_Entity> getNotAssignedHospital()
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_NotAssigned_Hospital();

            return list;
        }

        public List<Location_Entity> getHospitalsWithLocation()
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_Hospitals_With_Location();

            return list;            
        }

        public List<Location_Entity> getLocation()
        {
            Location_Dal obj = new Location_Dal();
            List<Location_Entity> list = obj.Get_Location();

            return list;
        }

        public void insertHospital(int idhospital, int idlocation, int uid, string date)
        {
            Location_Dal obj = new Location_Dal();
            obj.Insert_Hospital(idhospital, idlocation, uid, date);
        }

        public void insertLocation(int idhospital, int idlocation, int uid, string date)
        {
            Location_Dal obj = new Location_Dal();
            obj.Insert_Location(idhospital, idlocation, uid, date);
        }

        public void removeHospital(int uid, int idhospital)
        {
            Location_Dal obj = new Location_Dal();
            obj.Remove_Hospital(uid, idhospital);
        }

        public void removeLocation(int uid, int idhospital, int idlocation)
        {
            Location_Dal obj = new Location_Dal();
            obj.Remove_Location(uid, idhospital, idlocation);
        }
    }
}
