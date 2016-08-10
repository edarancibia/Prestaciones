<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Prestaciones.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
body
{
    font-size: 12px;    
}

.scrolling-table-container {
    height: 378px;
    overflow-y: scroll;
    overflow-x: hidden;
}

.foot
{
    float: right;    
}

.btnexa
{
    font-size: 12px;    
}

</style>
<script type="text/javascript">

    $(document).ready(function () {
        $("#<%=btnenvia.ClientID%>").click(function () {
            var a = $('#<%=txtcuerpo.ClientID %>').val();
            if (a != "") {
                if (confirm("¿Confirma que desea enviar el mensaje?")) {
                    var rut_sol = $('#<%=txtrutsoli.ClientID %>').text();
                    var nom_soli = $('#<%=txtnomsoli.ClientID %>').text();
                    var msj1 = $('#<%=txtcuerpo.ClientID %>').text();
                    $('#<%=txtcuerpo.ClientID %>').text(msj1 + ' ' + 'Solicitado por: ' + nom_soli + rut_sol);
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("Ingrese sus comentarios.");
                $("#<%=txtcuerpo.ClientID %>").focus();
                return false;
            }
        });

        $("#<%=Button1.ClientID%>").click(function () {
            var rut = $("#<%=txtrut.ClientID%>").val();
            if (rut == '') {
                alert('Digite Rut!');
                return false;
            }
        });

        $('#<%=txtnrofi.ClientID%>').hide();
        $('#<%=txtunidad.ClientID%>').hide();
    });

    $(document).ready(function () {
        var paciente = $('#<%=lblnombre.ClientID%>').text();
        var ckbox = $('#Checkbox1');
        var msj = $('#<%=txtcuerpo.ClientID%>').text();

        $('#Checkbox1').on('click', function () { //check ficha
            if (ckbox.is(':checked')) {
                $('#<%=txtnrofi.ClientID%>').show();
                $('#<%=txtnrofi.ClientID%>').focus();


                //var nrofi = $('#<%=txtnrofi.ClientID%>').val();
                $('#<%=txtcuerpo.ClientID %>').val(msj + ' ficha' + ' ' + paciente);

                $('#<%=txtnrofi.ClientID%>').blur(function () {
                    var ficha = $('#<%=txtnrofi.ClientID%>').val();
                    $('#<%=txtcuerpo.ClientID %>').val(msj + 'ficha N° ' + ficha + ' ' + 'del paciente ' + ' ' + paciente);
                });

            } else {
                $('#<%=txtnrofi.ClientID%>').hide();
                $('#<%=txtcuerpo.ClientID %>').val('');
            }
        });

        $('#Checkbox2').on('click', function () { //check examenes
            var ckbox = $('#Checkbox2');
            if (ckbox.is(':checked')) {
                $('#<%=txtunidad.ClientID%>').show();

                $('#<%=txtunidad.ClientID%>').blur(function () {
                    var unidad = $('#<%=txtunidad.ClientID%>').val();
                    $('#<%=txtcuerpoexa.ClientID %>').val(msj + ' exámen' + ' ' + unidad + ' ' + 'del paciente ' + paciente + '. Fecha: ');
                })

            } else {
                $('#<%=txtunidad.ClientID%>').hide();
                $('#<%=txtcuerpoexa.ClientID %>').val('');
            }
        });
    })


</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form name="form1" runat="server">
    <br />
        <div class="row">
            <div class="form-group">
                <div class="col-xs-3">
                    <asp:TextBox ID="txtrut" runat="server" placeholder="Ficha" class="form-control" MaxLength="8" ></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="Ingrese Rut" 
                        ControlToValidate="txtrut" Font-Bold="True" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                    <h5> Digite Rut sin puntos ni digito verificador.</h5>
                    <h5>Ejem: 14785985</h5>

                </div>
                <div class="col-xs-2">
                   <asp:Button ID="Button1" runat="server" Text="Buscar" 
                     class="btn btn-info" onclick="btnok_Click" data-toggle="modal" data-target="#myModal2" />       
     
                </div>

                <div class="col-xs-3">
                    <h5><strong><asp:Label ID="lblnombre" runat="server" Text="Label"></asp:Label></strong></h5>
                </div>

                <div class="col-xs-2">
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Exámenes en línea</asp:LinkButton>
                    <asp:ImageButton ID="ImageButton1" runat="server" 
                        ImageUrl="~/imagenes/news-exm.ico" onclick="ImageButton1_Click" ToolTip="Ir a resultado de exámenes en línea" />
                </div>

                <div class="col-xs-2">
                    <input id="btnmodal" type="button" value="Solicitar registros clínicos" class="btn btn-info btnexa" data-toggle="modal" data-target="#myModal" />
                </div>
            </div>
            </div>
 
            <div>
                <strong><asp:Label ID="lblerror" runat="server" Text="Label"></asp:Label></strong>
            </div>

            <div id="contenido" runat="server">
            <div class="row">
            <div class="form-group">
                <div class="col-md-3">
                    <h5><strong>Hospitalizaciones</strong></h5>
                    <div  style="height: 300px; overflow: scroll">
                        <asp:GridView ID="dgvhosp" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                        </asp:GridView>
                    </div>
                </div>

                <div class="col-md-3">
                <h5><strong>Urgencias</strong></h5>
                  <div  style="height: 300px; overflow: scroll">
                    <asp:GridView ID="dgvUrgencia" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                    </asp:GridView>
                  </div>
                </div>

                <div class="col-md-3">
                    <h5><strong>Exámenes y procedimientos</strong></h5>
                    <div  style="height: 300px; overflow: scroll">
                        <asp:GridView ID="dgvexam" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                        </asp:GridView>
                    </div>
                </div>

                <div class="col-md-3">
                    <h5><strong>Atenciones de enfermería</strong></h5>
                    <div  style="height: 300px; overflow: scroll">
                    <asp:GridView ID="dgvambula" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                    </asp:GridView>
                    </div>
                </div>
                
            </div>
            </div>
            <br />

            <div class="row">
                <div class="form-group">
                    <div class="col-md-3">
                        <h5><strong> Imagenología desde 1-07-2015</strong></h5>
                        <div  style="height: 300px; overflow: scroll">
                        <asp:GridView ID="dgvtoth" runat="server" 
                            class="table table-hover table-responsive" 
                            onrowdatabound="dgvtoth_RowDataBound" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                        </asp:GridView>
                        </div>
                    </div>

                    <div class="col-md-3" style="width:800px">
                        <h5><strong>Atenciones ambulatorias</strong></h5>
                        <div style="height: 200px; overflow: scroll; width: 800px" >
                        <asp:GridView ID="dgvconsul" runat="server" 
                            class="table table-hover table-responsive"  
                            onrowdatabound="dgvconsul_RowDataBound" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000" >
                        </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    
        <br /><br />
 
    <asp:Panel ID="Panel1" runat="server">
    
    <!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Enviar solicitud de registros clínicos</h4>
	      </div>
	      <div class="modal-body">
               
			<br/>

                <div class="row">
                  <div class="form-group">
                      <div class="col-xs-2">
                          Ficha
                          <input id="Checkbox1" type="checkbox" />
                      </div>

                      <div class="col-xs-2">
                          Exámen
                          <input id="Checkbox2" type="checkbox" />
                      </div>           
                  </div>
              </div>
              <br />

              <div class="row">
                  <div class="form-group">
                      <div class="col-xs-3">
                          <asp:TextBox ID="txtnrofi" runat="server" class="form-control" placeholder="Nro Ingreso"></asp:TextBox>
                      </div>
                      <div class="col-xs-3">
                          <asp:TextBox ID="txtunidad" runat="server" class="form-control" placeholder="Unidad"></asp:TextBox>
                      </div>
                  </div>
              </div>

             <br />

			 <div class="row">
			  	<div class="form-group">
			  	 <div class="col-lg-10">
                       <asp:TextBox ID="txtcuerpo" runat="server" TextMode="MultiLine" Rows="2" Columns="70" class="form-control" Text="Solicito : ">
                       </asp:TextBox>
                       <br />
                      <asp:TextBox ID="txtcuerpoexa" runat="server" TextMode="MultiLine" Rows="2" Columns="70" class="form-control" Text="Solicito : ">
                       </asp:TextBox>
                       <br />
                  
			  	</div>
			   </div>
			 </div>

              <br />

              <div class="row">
                  <div class="form-group">
                      <div class="col-xs-3">
                         <asp:TextBox ID="txtrutsoli" runat="server" placeholder="Rut" class="form-control"></asp:TextBox>
                      </div>
                      <div class="col-md-6">
                        <asp:TextBox ID="txtnomsoli" runat="server" placeholder="Nombre de quien solicita" class="form-control"></asp:TextBox>
                      </div>
                  </div>
              </div>

			 <br/>

              <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                      <ProgressTemplate>
                          Enviando...<asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/mail_gif.gif" />
                      </ProgressTemplate>
                  </asp:UpdateProgress>

	      <div class="modal-footer">
          <asp:ScriptManager ID="ScriptManager1" runat="server">
           </asp:ScriptManager>
           <div class="form-group" id="foot">
           
            <div class="col-xs-2">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>

            <div class="col-xs-2">
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                     <asp:Button ID="btnenvia" runat="server" Text="Enviar" class="btn btn-info" 
                    onclick="btnenvia_Click" />
                    </ContentTemplate> 
                </asp:UpdatePanel>
            </div>
           </div>

	      </div>
   
	    </div>
	  </div>
	</div>	
    </div>

    <!--MODAL CARGANDO... -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
       <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div id="modalCarga">
                <img src="imagenes/cargando.gif" alt="Alternate Text" style="display:block;margin:0 auto 0 auto;" />
            </div>
        </div>
       </div>
    </div>

    </asp:Panel>
    </form>
   
</asp:Content>
