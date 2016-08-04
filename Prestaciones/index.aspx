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
</style>
<script type="text/javascript">

    $(document).ready(function () {
        $("#<%=btnenvia.ClientID%>").click(function () {
            var a = $('#<%=txtcuerpo.ClientID %>').val();
            if (a != "") {
                if (confirm("¿Confirma que desea enviar el mensaje?")) {
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
    });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form name="form1" runat="server">
        <div class="row">
        <br />
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
                     class="btn btn-info" onclick="btnok_Click" />                  
     
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
                    <input id="btnmodal" type="button" value="Solicitar exámenes" class="btn btn-info" data-toggle="modal" data-target="#myModal" />
                </div>
            </div>
            </div>
 
            <div>
                <strong><asp:Label ID="lblerror" runat="server" Text="Label"></asp:Label></strong>
            </div>
            <br />

            <div id="contenido" runat="server">
            <div class="row">
            <div class="form-group">
                <div class="col-md-3">
                    <h5><strong>Hopitalizaciones</strong></h5>
                    <asp:GridView ID="dgvhosp" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                    </asp:GridView>
                </div>

                <div class="col-md-3">
                <h5><strong>Urgencias</strong></h5>
                    <asp:GridView ID="dgvUrgencia" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                    </asp:GridView>
                </div>

                <div class="col-md-3">
                   <div  style="height: 300px; overflow: scroll">
                    <h5><strong>Exámenes</strong></h5>
                        <asp:GridView ID="dgvexam" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                        </asp:GridView>
                    </div>
                </div>

                <div class="col-md-3">
                    <h5><strong>Otras atenciones ambulatorias</strong></h5>
                    <asp:GridView ID="dgvambula" runat="server" class="table table-hover table-responsive" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                    </asp:GridView>
                </div>
                
            </div>
            </div>
            <br /><br /> 

            <div class="row">
                <div class="form-group">
                    <div class="col-md-3">
                        <h5><strong> Imagenología desde 1-07-2015</strong></h5>
                        <asp:GridView ID="dgvtoth" runat="server" 
                            class="table table-hover table-responsive" 
                            onrowdatabound="dgvtoth_RowDataBound" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000">
                        </asp:GridView>
                    </div>

                    <div class="col-md-3" style="width:800px">
                        <h5><strong>Consultas médicas</strong></h5>
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
	        <h4 class="modal-title" id="myModalLabel">Enviar solicitud de resultados de exámenes a archivo</h4>
	      </div>
	      <div class="modal-body">
               
			<br/>
			 <div class="row">
			  	<div class="form-group">
			  	 <div class="col-lg-3">
                       <asp:TextBox ID="txtcuerpo" runat="server" TextMode="MultiLine" Rows="4" Columns="70">
                       </asp:TextBox>
                       <br />
                   <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                      <ProgressTemplate>
                          Enviando...<asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/mail_gif.gif" />
                      </ProgressTemplate>
                  </asp:UpdateProgress>

			  	</div>
			   </div>
			 </div>

			 <br/>
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
    </asp:Panel>
    </form>
   
</asp:Content>
