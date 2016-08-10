using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;
using System.Text;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Threading;
using System.Web.Services;
using System.Net.Mail;

namespace Prestaciones
{
    public class funciones
    {
        public string nombre;
        public string para,para2;
        public string asunto;
        public string cuerpo;
        public MailMessage correo;

        public void enviaCorreo()
        {
            try
            {
                correo = new MailMessage();
                correo.To.Add(new MailAddress(this.para));
                correo.CC.Add(new MailAddress(this.para2));
                correo.From = new MailAddress("prestacionescbo@outlook.com");
                correo.Subject = asunto;
                correo.Body = cuerpo;
                correo.IsBodyHtml = true;

                //SmtpClient client = new SmtpClient("smtp-mail.outlook.com", 587);
                SmtpClient client = new SmtpClient("smtp.live.com", 587);
                using (client)
                //using(SmtpClient client = new SmtpClient("smtp.live.com", 25))
                {
                    client.Credentials = new System.Net.NetworkCredential("prestacionescbo@outlook.com", "prestaciones1530");
                    client.EnableSsl = true;
                    client.Send(correo);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public bool buscaRut(string rut)
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

        public bool buscaRut2(string rut)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicbo"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select count(*) from PEM_PACIENTE where rut_num=@rut", con);
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

        public void obtNombre(string rut)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicbo"].ConnectionString))
              {
                  SqlCommand cmd = new SqlCommand("SELECT LTRIM(RTRIM(A_PAT))+' '+LTRIM(RTRIM(A_MAT))+' '+LTRIM(RTRIM(NOMBRE))nombre FROM PACIENTE WHERE RUT_NUM=@rut", con);
                  cmd.Parameters.AddWithValue("rut",rut);
                  con.Open();

                  SqlDataReader dr = cmd.ExecuteReader();

                  if (dr.Read())
                  {
                     nombre = dr["nombre"].ToString();

                  }
                  con.Close();
              }
        }

        public void obtNombre2(string rut)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicbo"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT LTRIM(RTRIM(A_PAT))+' '+LTRIM(RTRIM(A_MAT))+' '+LTRIM(RTRIM(NOMBRE))nombre FROM PEM_PACIENTE WHERE RUT_NUM=@rut", con);
                cmd.Parameters.AddWithValue("rut", rut);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    nombre = dr["nombre"].ToString();

                }
                con.Close();
            }
        }


        //HOSPITALIZACIONES
        public DataTable getHosp(string rut)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicbo"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT A.NRO_FI as 'Nro Ingreso',CONVERT(char(10), A.FECHA, 102) Fecha FROM FICHA A,FIC_PAC B WHERE A.NRO_FI=B.NRO_FI AND a.NRO_FI < 600000 AND B.RUT_NUM=@rut ORDER BY A.FECHA DESC", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("rut", rut);
                da.Fill(dt);
                cmd.Dispose();
                con.Close();
            }
            return dt;
        }

        //URGENCIAS
        public DataTable urgencias(string rut)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicbo"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT B.nro_fi as 'Dau' ,CONVERT(char(10), b.fechaingreso, 103)Fecha FROM HCA_FICHARUT A,HCA_FICHAPACIENTE B WHERE A.nro_fi=B.nro_fi AND A.rut_num=@rut ORDER BY B.FECHAINGRESO DESC", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("rut", rut);
                da.Fill(dt);
                cmd.Dispose();
                con.Close();
            }
            return dt;
        }

        //EXAMANES
        public DataTable examenes(string rut)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicboHistorico"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"SELECT DISTINCT CONVERT(char(10), A.FECHA, 102)Fecha,B.DESCRIP Unidad FROM O_A A,SECCION B,DET_O_SE C
		                                            WHERE A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION=19 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902 
		                                            OR A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION BETWEEN 22 AND 23 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902 AND A.FECHA < '07-01-2015'
		                                            OR	A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION BETWEEN 24 AND 26 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902
		                                            OR A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION BETWEEN 29 AND 30 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902 AND A.FECHA < '07-01-2015'
		                                            OR A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION=58 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902
		                                            OR A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION=62 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902 AND A.FECHA < '07-01-2015'
		                                            OR A.RUT_NUM=@rut AND A.C_SECCION=B.C_SECCION AND A.NRO_OA=c.NRO_OA AND A.PERIODO=C.PERIODO AND A.COD_ADM=C.COD_ADM AND a.C_SECCION=93 AND b.C_SECCION=c.C_SECCION AND c.COD_DET <> 39999902
                                            GROUP BY A.FECHA,B.DESCRIP,a.NRO_OA,c.COD_DET ORDER BY A.FECHA DESC", con);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("rut", rut);
                cmd.CommandTimeout = 60;
                da.Fill(dt);
                cmd.Dispose();
                con.Close();
            }
            return dt;
        }

        //ATENCIONES AMBULATORIAS
        public DataTable ambula(int rut)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cnsicboHca"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"SELECT HCE_AMB_REG_ENF.FECHA AS FECHA,NOMBRE
                                                  FROM HCE_AMB_REG_ENF,HCE_AMB_PROC
                                                  WHERE HCE_AMB_REG_ENF.RUT_PAC=@rut AND ID_REG=FK_ID_REG AND HCE_AMB_REG_ENF.ESTADO=1 AND HCE_AMB_REG_ENF.ESTADO1=1
                                                  UNION ALL
 
                                                  SELECT HCE_AMB_END.FECHA AS FECHA,NOMBRE
                                                  FROM HCE_AMB_END,HCE_AMB_ANT_MOR
                                                  WHERE RUT_NUM=@rut AND ID_END=FK_ID_END AND TIPO=4 AND HCE_AMB_END.ESTADO=1 AND HCE_AMB_END.ESTADO1=1

                                                  ORDER BY FECHA DESC", con);
                cmd.Parameters.AddWithValue("@rut", rut);
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
                con.Close();
            }
              return dt;
        }

        //toth
        public DataTable toth(string rut)
        {
            DataTable dt = new DataTable();
            string conS = "Driver={PostgreSql UNICODE};Server=192.9.200.152;Port=5432;Uid=informatica;Pwd=cao1234;Database=cao;";
            OdbcConnection conn = new OdbcConnection(conS);
            conn.Open();
            OdbcCommand cmd = new OdbcCommand("SELECT FECHA Fecha,SECCION Unidad FROM CUADRO_GENERAL WHERE RUT= ?", conn);
            cmd.Parameters.Add(new OdbcParameter("rut", rut));
            OdbcDataAdapter ada = new OdbcDataAdapter(cmd);

            ada.Fill(dt);
            conn.Close();

            return dt;
        }

        //CONSULTAS MEDICAS
        public DataTable consultas(string rut)
        {
            DataTable dt = new DataTable();

            System.Data.Odbc.OdbcConnection con = new System.Data.Odbc.OdbcConnection("Driver={FileMaker ODBC};Server=192.168.1.187;Database=AG_02; UID=cao2016;PWD=cao2016");
            con.Open();
            OdbcCommand cmd = new OdbcCommand("SELECT Horas.Fecha, Horas.\"Nombre Completo Medico en Horas\", Horas.Sucursal_Hora  FROM Horas WHERE (Horas.\"Rut Paciente\"=" + rut + ") ORDER BY Horas.Fecha DESC", con);

            OdbcDataAdapter da = new OdbcDataAdapter(cmd);
            cmd.Parameters.AddWithValue("rut", rut);
            da.Fill(dt);
            cmd.Dispose();
            con.Close();

            return dt;
        }
    }
}