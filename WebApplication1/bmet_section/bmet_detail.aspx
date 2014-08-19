<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bmet_detail.aspx.cs" Inherits="webapp_reports.Location_By_User.User_Detail1" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register assembly="DevExpress.XtraCharts.v12.2.Web, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts.Web" tagprefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>

<%@ Register assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>    
    <link href="../CSS/bmet_detail.css" rel="stylesheet" />

    <script type="text/javascript">        
        function closePopUp() {
            popBmetConfig.Hide();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      <fieldset style="width: 1130px">
            <legend> <asp:Label ID="Label2" runat="server" Text="BMET INFORMATION" Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label> </legend>
      <div class="main">
        <div class="section1">
<!-- BMET: IMAGE | NAME -->
          <div class="bmet_img">
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
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
              <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="BMET Workload" Font-Size="Medium"></dx:ASPxLabel>
          </div>

          <div class="detail_grid">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>                
                <dx:ASPxGridView ID="grdDetail" runat="server" AutoGenerateColumns="False" DataSourceID="SqlUserDetail">
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="Monthly Total:{0}" ShowInColumn="Location" SummaryType="Custom" />
                <dx:ASPxSummaryItem DisplayFormat="{0}" FieldName="PMs" ShowInColumn="PMs" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0}" FieldName="Completed_PMs" ShowInColumn="Completd PMs" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0}" FieldName="Priorities" ShowInColumn="Priorities" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0}" FieldName="Completed_Priorities" ShowInColumn="Completd Priorities" SummaryType="Sum" />
            </TotalSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Hospital" GroupIndex="0" ReadOnly="True" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                    <CellStyle Font-Bold="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                    <CellStyle HorizontalAlign="Left">
                    </CellStyle>
                    <FooterCellStyle Font-Bold="True">
                    </FooterCellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PMs" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Completd PMs" FieldName="Completed_PMs" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="% PMs" FieldName="Percentage_PMs" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Priorities" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Completd Priorities" FieldName="Completed_Priorities" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="% Priorities" FieldName="Percentage_Priorities" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsBehavior AutoExpandAllGroups="True" />
                    <SettingsPager PageSize="7">
                    </SettingsPager>
            <Settings GroupFormat="{1}" ShowFooter="True" />
            <Styles>
                <GroupRow Font-Bold="True">
                </GroupRow>
                <Cell HorizontalAlign="Center">
                </Cell>
                <Footer Font-Bold="False" ForeColor="Red" HorizontalAlign="Center">
                </Footer>
            </Styles>
        </dx:ASPxGridView>

            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlUserDetail" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="spS_Report_BMET_WO" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cmbUsers" DefaultValue="" Name="UserID" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
<!-- ENDs GRIDVIEW -->
          </div><!-- End's detail_grid div -->

          <div class="detail_mgnt">
<!-- CHART AREA1-->
            <div class="chart_area1">
              <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>

                  <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" DataSourceID="SqlMonthlyPMs" Height="271px" PaletteName="Concourse" Width="279px">
                    <diagramserializable>
                        <cc1:XYDiagram>
                            <axisx visibleinpanesserializable="-1">
                                <label font="Tahoma, 6pt">
                                </label>
                                <range sidemarginsenabled="True" />
                                <numericoptions format="General" />
                            </axisx>
                            <axisy visibleinpanesserializable="-1">
                                <range sidemarginsenabled="True" />
                                <numericoptions format="General" />
                            </axisy>
                        </cc1:XYDiagram>
                    </diagramserializable>
                    <FillStyle><OptionsSerializable>
                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                    </OptionsSerializable>
                    </FillStyle>

                    <seriesserializable>
                        <cc1:Series ArgumentDataMember="Description1" ArgumentScaleType="Qualitative" Name="Assigned" ValueDataMembersSerializable="Assigned_PMs">
                            <viewserializable>
                                <cc1:SideBySideBarSeriesView>
                                </cc1:SideBySideBarSeriesView>
                            </viewserializable>
                            <labelserializable>
                                <cc1:SideBySideBarSeriesLabel LineVisible="True">
                                    <fillstyle>
                                        <optionsserializable>
                                            <cc1:SolidFillOptions />
                                        </optionsserializable>
                                    </fillstyle>
                                    <pointoptionsserializable>
                                        <cc1:PointOptions>
                                            <argumentnumericoptions format="General" />
                                            <valuenumericoptions format="General" />
                                        </cc1:PointOptions>
                                    </pointoptionsserializable>
                                </cc1:SideBySideBarSeriesLabel>
                            </labelserializable>
                            <legendpointoptionsserializable>
                                <cc1:PointOptions>
                                    <argumentnumericoptions format="General" />
                                    <valuenumericoptions format="General" />
                                </cc1:PointOptions>
                            </legendpointoptionsserializable>
                        </cc1:Series>
                        <cc1:Series ArgumentDataMember="Description2" ArgumentScaleType="Qualitative" Name="Completed" ValueDataMembersSerializable="Completed_PMs">
                            <viewserializable>
                                <cc1:SideBySideBarSeriesView>
                                </cc1:SideBySideBarSeriesView>
                            </viewserializable>
                            <labelserializable>
                                <cc1:SideBySideBarSeriesLabel LineVisible="True">
                                    <fillstyle>
                                        <optionsserializable>
                                            <cc1:SolidFillOptions />
                                        </optionsserializable>
                                    </fillstyle>
                                    <pointoptionsserializable>
                                        <cc1:PointOptions>
                                            <argumentnumericoptions format="General" />
                                            <valuenumericoptions format="General" />
                                        </cc1:PointOptions>
                                    </pointoptionsserializable>
                                </cc1:SideBySideBarSeriesLabel>
                            </labelserializable>
                            <legendpointoptionsserializable>
                                <cc1:PointOptions>
                                    <argumentnumericoptions format="General" />
                                    <valuenumericoptions format="General" />
                                </cc1:PointOptions>
                            </legendpointoptionsserializable>
                        </cc1:Series>
                    </seriesserializable>

                    <SeriesTemplate><ViewSerializable>
                    <cc1:SideBySideBarSeriesView></cc1:SideBySideBarSeriesView>
                    </ViewSerializable>
                    <LabelSerializable>
                    <cc1:SideBySideBarSeriesLabel LineVisible="True">
                    <FillStyle><OptionsSerializable>
                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                    </OptionsSerializable>
                    </FillStyle>
                    <PointOptionsSerializable>
                    <cc1:PointOptions>
                    <ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

                    <ValueNumericOptions Format="General"></ValueNumericOptions>
                    </cc1:PointOptions>
                    </PointOptionsSerializable>
                    </cc1:SideBySideBarSeriesLabel>
                    </LabelSerializable>
                    <LegendPointOptionsSerializable>
                    <cc1:PointOptions>
                    <ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

                    <ValueNumericOptions Format="General"></ValueNumericOptions>
                    </cc1:PointOptions>
                    </LegendPointOptionsSerializable>
                    </SeriesTemplate>

                    <titles>
                        <cc1:ChartTitle Font="Tahoma, 13pt" Text="Monthly PM's" />
                    </titles>

                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                    </CommonLabelPositionSerializable>
                    </CrosshairOptions>

                    <ToolTipOptions><ToolTipPositionSerializable>
                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                    </ToolTipPositionSerializable>
                    </ToolTipOptions>
                  </dxchartsui:WebChartControl>

                  </ContentTemplate>
                  <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
                  </Triggers>
              </asp:UpdatePanel>              
              <asp:SqlDataSource ID="SqlMonthlyPMs" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="spS_Report_BMET_Monthly_PM_History" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cmbUsers" DefaultValue="" Name="UserID" PropertyName="Value" Type="Int32" />
                </SelectParameters>
              </asp:SqlDataSource>
            </div>

            <div class="chart_area1">
              <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>

                  <dxchartsui:WebChartControl ID="WebChartControl2" runat="server" DataSourceID="SqlMonthlyPMs" Height="271px" PaletteName="Concourse" Width="279px">
                    <diagramserializable>
                        <cc1:XYDiagram>
                            <axisx visibleinpanesserializable="-1">
                                <label font="Tahoma, 6pt">
                                </label>
                                <range sidemarginsenabled="True" />
                                <numericoptions format="General" />
                            </axisx>
                            <axisy visibleinpanesserializable="-1">
                                <range sidemarginsenabled="True" />
                                <numericoptions format="General" />
                            </axisy>
                        </cc1:XYDiagram>
                    </diagramserializable>
                    <FillStyle><OptionsSerializable>
                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                    </OptionsSerializable>
                    </FillStyle>

                    <seriesserializable>
                        <cc1:Series ArgumentDataMember="Description3" ArgumentScaleType="Qualitative" Name="Open WO" ValueDataMembersSerializable="Assigned_Priorities">
                            <viewserializable>
                                <cc1:SideBySideBarSeriesView>
                                </cc1:SideBySideBarSeriesView>
                            </viewserializable>
                            <labelserializable>
                                <cc1:SideBySideBarSeriesLabel LineVisible="True">
                                    <fillstyle>
                                        <optionsserializable>
                                            <cc1:SolidFillOptions />
                                        </optionsserializable>
                                    </fillstyle>
                                    <pointoptionsserializable>
                                        <cc1:PointOptions>
                                            <argumentnumericoptions format="General" />
                                            <valuenumericoptions format="General" />
                                        </cc1:PointOptions>
                                    </pointoptionsserializable>
                                </cc1:SideBySideBarSeriesLabel>
                            </labelserializable>
                            <legendpointoptionsserializable>
                                <cc1:PointOptions>
                                    <argumentnumericoptions format="General" />
                                    <valuenumericoptions format="General" />
                                </cc1:PointOptions>
                            </legendpointoptionsserializable>
                        </cc1:Series>
                        <cc1:Series ArgumentDataMember="Description4" ArgumentScaleType="Qualitative" Name="Completed" ValueDataMembersSerializable="Completed_Priorities">
                            <viewserializable>
                                <cc1:SideBySideBarSeriesView>
                                </cc1:SideBySideBarSeriesView>
                            </viewserializable>
                            <labelserializable>
                                <cc1:SideBySideBarSeriesLabel LineVisible="True">
                                    <fillstyle>
                                        <optionsserializable>
                                            <cc1:SolidFillOptions />
                                        </optionsserializable>
                                    </fillstyle>
                                    <pointoptionsserializable>
                                        <cc1:PointOptions>
                                            <argumentnumericoptions format="General" />
                                            <valuenumericoptions format="General" />
                                        </cc1:PointOptions>
                                    </pointoptionsserializable>
                                </cc1:SideBySideBarSeriesLabel>
                            </labelserializable>
                            <legendpointoptionsserializable>
                                <cc1:PointOptions>
                                    <argumentnumericoptions format="General" />
                                    <valuenumericoptions format="General" />
                                </cc1:PointOptions>
                            </legendpointoptionsserializable>
                        </cc1:Series>
                    </seriesserializable>

                    <SeriesTemplate><ViewSerializable>
                    <cc1:SideBySideBarSeriesView></cc1:SideBySideBarSeriesView>
                    </ViewSerializable>
                    <LabelSerializable>
                    <cc1:SideBySideBarSeriesLabel LineVisible="True">
                    <FillStyle><OptionsSerializable>
                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                    </OptionsSerializable>
                    </FillStyle>
                    <PointOptionsSerializable>
                    <cc1:PointOptions>
                    <ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

                    <ValueNumericOptions Format="General"></ValueNumericOptions>
                    </cc1:PointOptions>
                    </PointOptionsSerializable>
                    </cc1:SideBySideBarSeriesLabel>
                    </LabelSerializable>
                    <LegendPointOptionsSerializable>
                    <cc1:PointOptions>
                    <ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

                    <ValueNumericOptions Format="General"></ValueNumericOptions>
                    </cc1:PointOptions>
                    </LegendPointOptionsSerializable>
                    </SeriesTemplate>

                    <titles>
                        <cc1:ChartTitle Font="Tahoma, 13pt" Text="Monthly Priorities" />
                    </titles>

                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                    </CommonLabelPositionSerializable>
                    </CrosshairOptions>

                    <ToolTipOptions><ToolTipPositionSerializable>
                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                    </ToolTipPositionSerializable>
                    </ToolTipOptions>
                  </dxchartsui:WebChartControl>

                </ContentTemplate>
                <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
                </Triggers>    
              </asp:UpdatePanel>             
            </div>
<!-- ENDs CHART AREA1-->          
          </div><!--detail_management-->
      </div><!--section2-->
      <div class="section3">
        <div class="select_bmet_area">
          <div class="select_bmet">
            <fieldset style="width: 520px"> <legend> <asp:Label ID="Label3" runat="server" Text="Switch BMET Area..." Font-Bold="False" Font-Names="Calibri" Font-Size="Large"></asp:Label> </legend>            
              <table>
                <tr>
                <td style="width: 70px;"> <span style="float: right"><dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="BMET: " Font-Bold="True"></dx:ASPxLabel> </span></td>                
                <td> <dx:ASPxComboBox ID="cmbUsers" runat="server" ValueType="System.String" Width="200px" AutoPostBack="True" IncrementalFilteringMode="Contains" OnSelectedIndexChanged="cmbUsers_SelectedIndexChanged" OnInit="cmbUsers_Init" ClientInstanceName="cmbUsers"></dx:ASPxComboBox></td>                
                </tr>
              </table>
            </fieldset>
          </div>
          <div class="btn_overview"> 
            <table> 
              <tr>
                <td style="width: 90px;">
                  <dx:ASPxButton ID="btnManage" runat="server" Text="Manage" Height="35px" Width="80px" Font-Size="0.91em" AutoPostBack="False" CausesValidation="False" Theme="Metropolis" ClientInstanceName="btnManage">
                    <ClientSideEvents Click="function(s, e) {
                    var uIndex = cmbUsers.GetSelectedIndex();
                    popBmetConfig.SetContentUrl(&quot;../bmet_section/bmet_config.aspx?UID=&quot; + uIndex);
                    popBmetConfig.Show();}" />            
                  </dx:ASPxButton>
                </td>
                <td style="width: 90px;">
                  <dx:ASPxButton ID="btnClose" runat="server" Text="Close" Height="35px" Width="80px" Font-Size="0.91em" AutoPostBack="False" CausesValidation="False" Theme="Metropolis" ClientInstanceName="btnClose">
                    <ClientSideEvents Click="function(s, e) {window.parent.closePopUp();}" />                          
                  </dx:ASPxButton>                          
                </td>
              </tr>
            </table>
          </div>
        </div>
        
<!-- YEARLY CHART-->
        <div class="chart_area2">
          <asp:UpdatePanel ID="UpdatePanel5" runat="server">
            <ContentTemplate>

              <dxchartsui:WebChartControl ID="WebChartControl3" runat="server" DataSourceID="SqlYearlyPMs" Height="210px" PaletteName="Concourse" Width="565px">
                  <diagramserializable>
                      <cc1:XYDiagram>
                          <axisx visibleinpanesserializable="-1">
                              <range sidemarginsenabled="True" />
                              <numericoptions format="General" />
                          </axisx>
                          <axisy visibleinpanesserializable="-1">
                              <constantlines>
                                  <cc1:ConstantLine AxisValueSerializable="90" Color="255, 0, 0" Name="Threshold">
                                      <linestyle thickness="2" />
                                  </cc1:ConstantLine>
                              </constantlines>
                              <range sidemarginsenabled="True" Auto="False" MaxValueSerializable="100" MinValueSerializable="0" />
                              <numericoptions format="General" />
                          </axisy>
                      </cc1:XYDiagram>
                  </diagramserializable>
                    <FillStyle><OptionsSerializable>
                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                    </OptionsSerializable>
                    </FillStyle>

                  <seriesserializable>
                      <cc1:Series ArgumentDataMember="Month" ArgumentScaleType="Qualitative" Name="Series 1" ValueDataMembersSerializable="Percentage">
                          <viewserializable>
                              <cc1:LineSeriesView>
                                  <linemarkeroptions visible="True">
                                  </linemarkeroptions>
                              </cc1:LineSeriesView>
                          </viewserializable>
                          <labelserializable>
                              <cc1:PointSeriesLabel LineVisible="True">
                                  <fillstyle>
                                      <optionsserializable>
                                          <cc1:SolidFillOptions />
                                      </optionsserializable>
                                  </fillstyle>
                                  <pointoptionsserializable>
                                      <cc1:PointOptions>
                                          <argumentnumericoptions format="General" />
                                          <valuenumericoptions format="General" />
                                      </cc1:PointOptions>
                                  </pointoptionsserializable>
                              </cc1:PointSeriesLabel>
                          </labelserializable>
                          <legendpointoptionsserializable>
                              <cc1:PointOptions>
                                  <argumentnumericoptions format="General" />
                                  <valuenumericoptions format="General" />
                              </cc1:PointOptions>
                          </legendpointoptionsserializable>
                      </cc1:Series>
                  </seriesserializable>
                  <seriestemplate>
                      <viewserializable>
                          <cc1:LineSeriesView>
                              <linemarkeroptions visible="True">
                              </linemarkeroptions>
                          </cc1:LineSeriesView>
                      </viewserializable>
                      <labelserializable>
                          <cc1:PointSeriesLabel LineVisible="True">
                              <fillstyle>
                                  <optionsserializable>
                                      <cc1:SolidFillOptions />
                                  </optionsserializable>
                              </fillstyle>
                              <pointoptionsserializable>
                                  <cc1:PointOptions>
                                      <argumentnumericoptions format="General" />
                                      <valuenumericoptions format="General" />
                                  </cc1:PointOptions>
                              </pointoptionsserializable>
                          </cc1:PointSeriesLabel>
                      </labelserializable>
                      <legendpointoptionsserializable>
                          <cc1:PointOptions>
                              <argumentnumericoptions format="General" />
                              <valuenumericoptions format="General" />
                          </cc1:PointOptions>
                      </legendpointoptionsserializable>
                  </seriestemplate>
                  <titles>
                      <cc1:ChartTitle Font="Tahoma, 14pt" Text="PM's YTD %" />
                  </titles>

                <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                </CommonLabelPositionSerializable>
                </CrosshairOptions>

                <ToolTipOptions><ToolTipPositionSerializable>
                <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                </ToolTipPositionSerializable>
                </ToolTipOptions>
                </dxchartsui:WebChartControl>

              </ContentTemplate>
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
              </Triggers>    
            </asp:UpdatePanel>

            <asp:SqlDataSource ID="SqlYearlyPMs" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="spS_Report_BMET_Yearly_PM_History" SelectCommandType="StoredProcedure">
              <SelectParameters>
                  <asp:ControlParameter ControlID="cmbUsers" DefaultValue="" Name="UserID" PropertyName="Value" Type="Int32" />
              </SelectParameters>
            </asp:SqlDataSource>
        </div>
<!-- ENDs YEARLY CHART-->        
      </div><!--section3-->        
    </div><!--main-->
    </fieldset>
<!-- HIDDEN FIELDs AREA -->
     <asp:HiddenField ID="hidden_uindex" runat="server" />
<!-- ENDs HIDDEN FIELDs AREA -->
<!-- POP-UP USER MANAGEMENT AREA -->
     <dx:ASPxPopupControl ID="popBmetConfig" runat="server" ClientInstanceName="popBmetConfig" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Height="568px" Width="965px" HeaderText="BMET Configuration" AllowDragging="True"></dx:ASPxPopupControl>
<!-- ENDs POP-UP USER MANAGEMENT AREA -->
    </form>
</body>
</html>
