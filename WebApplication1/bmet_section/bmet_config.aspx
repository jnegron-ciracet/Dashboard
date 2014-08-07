<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bmet_config.aspx.cs" Inherits="webapp_reports.Location_By_User.User_Detail" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxRoundPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <title></title>
    <link href="../CSS/normalize.css" rel="stylesheet" />
    <link href="../CSS/bmet_config.css" rel="stylesheet" />

</head>
<body>
    <script type="text/javascript">
        
        function showPopLocation() {
            var byLocation = document.getElementById("hiddenByLocation").value;            
            if (byLocation == 1) {
                popLocation.Show();
            }            
            else {
                return;
            }           
        }

        function showPopHospital() {
            var location2Index = document.getElementById("hiddenLocation2Index").value;
            
            if (location2Index == "") {
                return;
            }
            else if (location2Index == 0 || location2Index > 0) {
                popHospital.Show();
            }
            else {
                return;
            }            
        }

        function showPopRemoveHospital() {
            var open = document.getElementById("hiddenOpenPopRemove").value;

            if (open == "1") {
                popRemoveLocation.Show();
            }
            else {
                return;
            }
        }

        function closePopUp() {
            popLocation.Hide();
            popHospital.Hide();
            popRemoveLocation.Hide();
        }


    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      <fieldset style="width: 900px">
            <legend> <asp:Label ID="Label2" runat="server" Text="BMET INFORMATION" Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label> </legend>
      <div class="main">
        <div class="section1">
<!-- BMET: IMAGE | NAME -->
          <div class="bmet_img">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
              <ContentTemplate>   
                <dx:ASPxBinaryImage ID="ImgUser" runat="server" Height="120px" Width="120px">
                  <EmptyImage Height="120px" Url="~/Images/user.jpg" Width="120px"></EmptyImage>                
                <Border BorderColor="#E5E5E5" BorderStyle="Inset" BorderWidth="1px" /></dx:ASPxBinaryImage>
              </ContentTemplate>
              <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
              </Triggers>
            </asp:UpdatePanel>            
          </div>
          <div class="bmet_name">            
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <dx:ASPxLabel ID="lblUserName" runat="server" Font-Names="Lucida Console" Font-Size="XX-Large" Text="BMET Name"></dx:ASPxLabel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>                                                          
          </div>
        </div><!-- End's section1 div -->
<!-- ENDs BMET: IMAGE | NAME -->

        <div class="section2">
<!-- GRIDVIEW -->
          <div class="grid_hder">
              <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Hospital & Location: " Font-Size="Medium"></dx:ASPxLabel>
          </div>

          <div class="detail_grid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>                
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" Theme="Default" AutoGenerateColumns="False" DataSourceID="SqlUserDetail" Width="390px" EnableTheming="True">
                    <Columns>                
                        <dx:GridViewDataTextColumn FieldName="InicialesHospital" VisibleIndex="1" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Location" ReadOnly="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="Date_Assigned" VisibleIndex="3">
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <SettingsBehavior AllowDragDrop="False" AutoExpandAllGroups="True" ProcessSelectionChangedOnServer="True" />
                    <SettingsPager PageSize="8">
                    </SettingsPager>
                    <Settings GroupFormat="{1}" />
                    <Styles>
                        <GroupRow Font-Bold="True" Wrap="True">
                        </GroupRow>
                        <Cell Wrap="True">
                        </Cell>
                    </Styles>
                  </dx:ASPxGridView>                
                <asp:SqlDataSource ID="SqlUserDetail" runat="server" ConnectionString="Data Source=CIRACETSRV002\CIRACETSRV002;Initial Catalog=CiracetNew;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT	s.Name + ' ' + s.FirstLastName + ' ' + s.SecondLastName As 'BMET', 
		        ho.InicialesHospital, ISNull(l.Nombre, 'N/A') As Location, lu.Date_Assigned

        FROM	LocationUsers As lu Inner Join
		        SecUsers As s On lu.UserID = s.UserID Inner Join
		        Hospital_ByLocation As h On lu.IDInstitucion = h.ID Left Outer Join
		        Hospital As ho On h. ID = ho.IDInstitucion Left Outer Join
		        Location As l On lu.IDLocation = l.ID

        WHERE 	lu.UserID = @UID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cmbUsers" DefaultValue="" Name="UID" PropertyName="Value" />
                    </SelectParameters>
                      </asp:SqlDataSource>

            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
<!-- ENDs GRIDVIEW -->
          </div><!-- End's detail_grid div -->

          <div class="detail_mgnt">
<!-- DETAIL FIELDSET-->
        <fieldset style="width: 450px;">
            <legend> <asp:Label ID="Label1" runat="server" Text="Details Management Area..." Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label> </legend>                                                          
            <table>
                <tr>
                  <td style="width: 70px;"> <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Hospital: " Font-Names="Calibri" Font-Size="Medium" Font-Bold="True"></dx:ASPxLabel> </td>
                  <td> <dx:ASPxComboBox ID="cmbHospital" runat="server" OnSelectedIndexChanged="cmbHospital_SelectedIndexChanged" Width="200px" IncrementalFilteringMode="Contains"></dx:ASPxComboBox></td>
                  <td style="width:5px;"></td>
                  <td> <dx:ASPxButton ID="btnHospital_Add" runat="server" Text="Add" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" OnClick="btnHospital_Add_Click" ClientInstanceName="btnAddHospital" AutoPostBack="False" CausesValidation="False" UseSubmitBehavior="False">
                      </dx:ASPxButton> </td>
                  <td> <dx:ASPxButton ID="btnHospital_Remove" runat="server" Text="Remove" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" OnClick="btnHospital_Remove_Click"></dx:ASPxButton> </td>
                </tr>
            </table>
            <div style="padding-bottom:10px;"></div>
            <table>
                <tr>                    
                  <td style="width: 70px;"> <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Location: " Font-Names="Calibri" Font-Size="Medium" Font-Bold="True"></dx:ASPxLabel> </td> 
                  <td> <dx:ASPxComboBox ID="cmbLocation2" runat="server" Width="200px" OnSelectedIndexChanged="cmbLocation2_SelectedIndexChanged" IncrementalFilteringMode="Contains" ClientInstanceName="cmbLocation2"></dx:ASPxComboBox> </td>
                  <td style="width:10px;"></td>
                  <td> <dx:ASPxButton ID="btnLocation_Add" runat="server" Text="Add" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnAddLocation" OnClick="btnLocation_Add_Click">
                      </dx:ASPxButton> </td>
                  <td> <dx:ASPxButton ID="btnLocationl_Remove" runat="server" Text="Remove" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" OnClick="btnLocationl_Remove_Click">
                      </dx:ASPxButton> </td>
                </tr>  
            </table>                                       
          </fieldset>
<!-- ENDs DETAIL FIELDSET-->          

          <div class="select_bmet">
            <fieldset style="width: 450px"> <legend> <asp:Label ID="Label3" runat="server" Text="Switch BMET Area..." Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label> </legend>            
                <table>
                  <tr>
                    <td style="width: 70px;"> <span style="float: right"><dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="BMET: " Font-Bold="True"></dx:ASPxLabel> </span></td>                
                    <td> <dx:ASPxComboBox ID="cmbUsers" runat="server" ValueType="System.String" Width="200px" AutoPostBack="True" IncrementalFilteringMode="Contains" OnSelectedIndexChanged="cmbUsers_SelectedIndexChanged" OnInit="cmbUsers_Init" OnLoad="cmbUsers_Load"></dx:ASPxComboBox></td>                
                  </tr>
                </table>
            </fieldset>
          </div>
          <div class="btn_overview"> 
              <table> 
              <tr>
                <td style="width: 90px;">
                  <dx:ASPxButton ID="btnClear" runat="server" Text="Clear" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" AutoPostBack="False" ClientInstanceName="btnDetail" OnClick="btnClear_Click"></dx:ASPxButton>                  
                </td>
                <td style="width: 90px;">
                  <dx:ASPxButton ID="btnDetail" runat="server" Text="Close" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" AutoPostBack="False" ClientInstanceName="btnDetail"><ClientSideEvents Click="function(s, e) {window.parent.HidePopup();}" />
                  </dx:ASPxButton>                                  
                </td>
              </tr>
            </table>
          </div>

        </div><!--detail_management-->
      </div><!--section2-->
    </div><!--main-->
    </fieldset>
    
           
<!-- HIDDEN FIELDs-->
          <asp:HiddenField ID="hiddenByLocation" runat="server" />
          <asp:HiddenField ID="hiddenLocation2Index" runat="server" />
          <asp:HiddenField ID="hiddenOpenPopRemove" runat="server" />
<!-- ENDs HIDDEN FIELDs -->
<!-- ENDs DETAIL FIELDSET -->

<!-- POP UP ADD LOCATION -->
          <dx:ASPxPopupControl ID="popLocation" runat="server" CloseAction="CloseButton" HeaderText="Select Location" Modal="True" 
              PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="450px" ClientInstanceName="popLocation" OnLoad="popLocation_Load">
              <ContentCollection>
                  <dx:PopupControlContentControl runat="server">                      
                      <table>
                          <tr>
                            <td> <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Location: " Font-Names="Calibri" Font-Size="Medium" Font-Bold="True"></dx:ASPxLabel> </td>
                            <td> <dx:ASPxComboBox ID="cmbLocation1" runat="server" ValueType="System.String" Width="200px" OnSelectedIndexChanged="cmbLocation1_SelectedIndexChanged" IncrementalFilteringMode="Contains"></dx:ASPxComboBox> </td>
                            <td style="width:10px;"></td>
                            <td> <dx:ASPxButton ID="btnSaveLocation" runat="server" Text="Save" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" OnClick="btnSaveLocation_Click">
                                <ClientSideEvents Click="showPopLocation" />
                                </dx:ASPxButton> </td>
                            <td> <dx:ASPxButton ID="btnCancelLocation" runat="server" Text="Cancel" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnCancelLocation">
                                <ClientSideEvents Click="closePopUp" />
                                </dx:ASPxButton> </td>                            
                          </tr>
                      </table>
                  </dx:PopupControlContentControl>
              </ContentCollection>
          </dx:ASPxPopupControl>
<!-- ENDs POP UP ADD LOCATION -->

<!-- POP-UP ADD HOSPITAL -->                    
          <dx:ASPxPopupControl ID="popHospital" runat="server" CloseAction="CloseButton" HeaderText="Select Hospital" Modal="True" 
              PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="450px" ClientInstanceName="popHospital" OnLoad="popHospital_Load">
              <ContentCollection>
                  <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">                      
                      <table>
                          <tr>
                            <td> <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Hospital: " Font-Names="Calibri" Font-Size="Medium" Font-Bold="True"></dx:ASPxLabel> </td>
                            <td> <dx:ASPxComboBox ID="cmbHospital2" runat="server" ValueType="System.String" Width="200px" IncrementalFilteringMode="Contains"></dx:ASPxComboBox> </td>
                            <td style="width:10px;"></td>
                            <td> <dx:ASPxButton ID="btnSaveHospital" runat="server" Text="Save" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnSaveHospital" OnClick="btnSaveHospital_Click">
                                <ClientSideEvents/>
                                </dx:ASPxButton> </td>                            
                            <td> <dx:ASPxButton ID="btnCancelHospital" runat="server" Text="Cancel" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnCancelHospital">
                                <ClientSideEvents Click="closePopUp" />
                                </dx:ASPxButton> </td>
                          </tr>
                      </table>
                  </dx:PopupControlContentControl>
              </ContentCollection>
          </dx:ASPxPopupControl>
<!-- ENDs POP-UP ADD HOSPITAL -->

<!-- POP-UP REMOVE LOCATION -->        
        <dx:ASPxPopupControl ID="popRemoveLocation" runat="server" CloseAction="CloseButton" HeaderText="Remove Hospital" Modal="True" 
              PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="450px" ClientInstanceName="popRemoveLocation" OnLoad="popRemoveLocation_Load">
              <ContentCollection>
                  <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">                      
                      <table>
                          <tr>
                            <td> <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Hospital: " Font-Names="Calibri" Font-Size="Medium" Font-Bold="True"></dx:ASPxLabel> </td>
                            <td> <dx:ASPxComboBox ID="cmbHospital3" runat="server" ValueType="System.String" Width="200px" IncrementalFilteringMode="Contains"></dx:ASPxComboBox> </td>
                            <td style="width:10px;"></td>
                            <td> <dx:ASPxButton ID="btnRemoveLocation" runat="server" Text="Remove" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnRemoveLocation" OnClick="btnRemoveLocation_Click">
                                <ClientSideEvents/>
                                </dx:ASPxButton> </td>                            
                            <td> <dx:ASPxButton ID="btnCancelLocation2" runat="server" Text="Cancel" Height="35px" Width="80px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnCancelHospital">
                                <ClientSideEvents Click="closePopUp" />
                                </dx:ASPxButton> </td>
                          </tr>
                      </table>
                  </dx:PopupControlContentControl>
              </ContentCollection>
          </dx:ASPxPopupControl>
<!-- POP-UP REMOVE LOCATION -->                                                                       
    </form>    
</body>
</html>
