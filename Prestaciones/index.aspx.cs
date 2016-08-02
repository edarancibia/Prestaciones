using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using System.Configuration;

namespace Prestaciones
{
    public partial class index : System.Web.UI.Page
    {
        funciones objFunc = new funciones();
        public string rutCompleto,rutFinal;

        protected void Page_Load(object sender, EventArgs e)
        {
            txtrut.Focus();
            lblnombre.Visible = false;
            lblerror.Visible = false;
            contenido.Visible = false;
        }

        public static string Dv(string r)
        {
            int suma = 0;
            for (int x = r.Length - 1; x >= 0; x--)
                suma += int.Parse(char.IsDigit(r[x]) ? r[x].ToString() : "0") * (((r.Length - (x + 1)) % 6) + 2);
            int numericDigito = (11 - suma % 11);
            string digito = numericDigito == 11 ? "0" : numericDigito == 10 ? "K" : numericDigito.ToString();
            return digito;
        }

        public String formatear(String rut)
        {
            int cont = 0;
            String format;
            if (rut.Length == 0)
            {
                return "";
            }
            else
            {
                rut = rut.Replace(".", "");
                rut = rut.Replace("-", "");
                format = "-" + rut.Substring(rut.Length - 1);
                for (int i = rut.Length - 2; i >= 0; i--)
                {

                    format = rut.Substring(i, 1) + format;

                    cont++;
                    if (cont == 3 && i != 0)
                    {
                        format = "." + format;
                        cont = 0;
                    }
                }
                return format;
            }
        }

        protected void btnok_Click(object sender, EventArgs e)
        {
          if (!objFunc.buscaRut(txtrut.Text) && !objFunc.buscaRut2(txtrut.Text))
            {
                lblerror.Text = "Rut no encontrado";
                txtrut.Text = "";
                lblnombre.Visible = false;
                lblerror.Visible = true;
                txtrut.Focus();
                contenido.Visible = false;
            }
             else {
                //System.Threading.Thread.Sleep(5000);
                objFunc.obtNombre(txtrut.Text);
                if (objFunc.nombre == null)
                {
                    objFunc.obtNombre2(txtrut.Text);
                }

                lblnombre.Text = objFunc.nombre.ToString();
                lblnombre.Visible = true;

                string dig = Dv(txtrut.Text);
                rutCompleto = txtrut.Text + dig.ToString();
                rutFinal = formatear(rutCompleto);

                dgvUrgencia.DataSource = objFunc.urgencias(txtrut.Text);
                dgvUrgencia.DataBind();

                dgvhosp.DataSource = objFunc.getHosp(txtrut.Text);
                dgvhosp.DataBind();

                dgvexam.DataSource = objFunc.examenes(txtrut.Text);
                dgvexam.DataBind();

                dgvambula.DataSource = objFunc.ambula(Convert.ToInt32(txtrut.Text));
                dgvambula.DataBind();

                dgvtoth.DataSource = objFunc.toth(rutFinal);
                dgvtoth.DataBind();

                dgvconsul.DataSource = objFunc.consultas(txtrut.Text);
                dgvconsul.DataBind();

                contenido.Visible = true;
           }
        }

        private void grillaKoplad()
        {
            dgvconsul.AutoGenerateColumns = false;

        }

        protected void dgvconsul_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[1].Text = "Médico";
                e.Row.Cells[2].Text = "Especialidad";
                e.Row.Cells[3].Text = "Sucursal";
                
            }

            foreach (TableCell cell in e.Row.Cells)
            {
                if (cell.Text.Length > 0)
                    cell.Text = "<nobr>" + cell.Text + "</nobr>";
            }
        }

        protected void dgvtoth_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string idSec = e.Row.Cells[1].Text.ToString();

                switch (idSec)
                {
                    case "62":
                        e.Row.Cells[1].Text = "RESONANCIA";break;
                    case "23":
                        e.Row.Cells[1].Text = "RAYOS X";break;
                    case "22":
                        e.Row.Cells[1].Text = "RAYOS ECOTOMOGRAFIA";break;
                    case "29":
                        e.Row.Cells[1].Text = "MOMOGRAFIA";break;
                    case "30":
                        e.Row.Cells[1].Text = "SCANNER";break;
                }
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("http://192.168.1.136:8886");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://192.168.1.136:8886");
        }

        protected void btnenvia_Click(object sender, EventArgs e)
        {
            objFunc.para = "erwin.arancibia@clinicale.cl";
            objFunc.para2 = "erwin2211@hotmail.com";
            objFunc.asunto = "Solicitud de exámenes";
            objFunc.cuerpo = txtcuerpo.Text;
            objFunc.enviaCorreo();
        }

    }
}