using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;

namespace Datos
{
    class Funciones
    {

        private bool buscaRut(string rut)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicbo"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select count(*) from paciente where rut_num=@rut", con);
                cmd.Parameters.AddWithValue("rut", rut);

                int existe = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
                if (existe > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
    }
}
