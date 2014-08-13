<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="WebApplication1.dashboard.dash" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.XtraCharts.v12.2.Web, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v12.2, Version=12.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Central App</title>
    <meta name="viewport" content="width=device-width"/>
    <!-- CSS STYLE -->
    <link href="../CSS/normalize.css" rel="stylesheet" />
    <link href="../CSS/dash.css" rel="stylesheet" />
    <!-- JAVA SCRIPT -->
    <script src="../JS/resize.js"></script>
    <script src="../JS/slider.js"></script>
    <script type="text/javascript">

        function closePopUp() {
            popHospital.Hide();
            popUser.Hide();            
        }

        function getBmetValue() {
            var id = document.getElementById('hdn_bmetid').value;
            alert("value = " + id);
        }
                      
    </script>
</head>
<body>
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
              
      <!-- DIV: WRAP -->        
        <div class="wrap">
        <!-- SECTION1 -->  
          <section>
            <div class="top-boxes"><i class="entypo-clipboard"></i><p><span><asp:Label ID="lblOpenPM" runat="server" Text="Label"></asp:Label></span> <asp:Label ID="lblMonth1" runat="server" Text="Label"></asp:Label> Opened PMs</p></div>
            <div class="top-boxes"><i class="entypo-attention"></i><p><span><asp:Label ID="lblOpenedPriorities" runat="server" Text="Label"></asp:Label></span> <asp:Label ID="lblMonth2" runat="server" Text="Label"></asp:Label> PM's Priorities</p></div>
            <div class="top-boxes"><i class="entypo-basket"></i><p><span><asp:Label ID="lblPendingPickUp1" runat="server" Text=""></asp:Label></span> Uncollected Parts</p></div>
            <div class="top-boxes"><i class="entypo-docs"></i><p><span><asp:Label ID="lblOpenedWO" CssClass="overall" runat="server" Text=""></asp:Label></span> Total Opened WO</p></div>
          </section><!-- END: SECTION1 -->
        
        <!-- SECTION2 -->
          <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" OnLoad="UpdatePanel1_Load">
            <ContentTemplate>
              <section class="wrap-chart">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" OnLoad="UpdatePanel2_Load">
                  <ContentTemplate>
                    <!-- DIV: CHART 1 -->                
                    <div id="resize-chrt1" class="chart-container">                        
                      <header class="chart-header">
                        <h3><dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Monthly PM's By Hospital ("></dx:ASPxLabel>                                                        
                            <dx:ASPxLabel ID="lblSelectedHospital" runat="server" Text=""></dx:ASPxLabel> )
                        </h3>                      
                        <p>Overall <span><asp:Label ID="lblPMCompliance" CssClass="overall" runat="server" Text=""></asp:Label>%</span>
                            <dx:ASPxLabel ID="lblTool1" runat="server" CssClass="entypo-tools">
                                <ClientSideEvents Click="function(s, e) { popHospital.Show(); }" /></dx:ASPxLabel>
                        </p>
                      </header>                        
                      <div id="chrt1_summary" class="chart-body" runat="server">
                          <dxchartsui:WebChartControl ID="WebChartControl3" runat="server" DataSourceID="SqlDataSource3" Height="230px" Width="600px" PaletteName="Palette 1" BackColor="Transparent" ClientInstanceName="WebChartControl3" ShowLoadingPanel="False" >
                                <borderoptions visible="False" />
                                <diagramserializable>
                                    <cc1:XYDiagram>
                                        <axisx visibleinpanesserializable="-1">
                                            <label angle="-90" font="Calibri, 9pt" textcolor="75, 75, 75">
                                            </label>
                                            <range sidemarginsenabled="True" />
                                            <numericoptions format="General" />
                                        </axisx>
                                        <axisy visibleinpanesserializable="-1">
                                            <constantlines>
                                                <cc1:ConstantLine AxisValueSerializable="90" Color="Red" LegendText="Treshhold" Name="Treshhold">
                                                    <linestyle dashstyle="Solid" />
                                                </cc1:ConstantLine>
                                            </constantlines>
                                            <label textcolor="75, 75, 75" font="Calibri, 9pt">
                                            </label>
                                            <range sidemarginsenabled="True" auto="False" maxvalueserializable="100" minvalueserializable="0" />
                                            <gridlines color="224, 224, 224">
                                            </gridlines>
                                            <numericoptions format="General" />
                                        </axisy>
                                        <defaultpane backcolor="Transparent">
                                        </defaultpane>
                                    </cc1:XYDiagram>
                                </diagramserializable>
                                <FillStyle><OptionsSerializable>
                                <cc1:SolidFillOptions></cc1:SolidFillOptions>
                                </OptionsSerializable>
                                </FillStyle>

                                <legend alignmenthorizontal="Right" alignmentvertical="TopOutside" direction="LeftToRight" equallyspaceditems="False" markersize="18, 10" backcolor="Transparent">
                                    <border visible="False" />
                                </legend>

                                <seriesserializable>
                                    <cc1:Series ArgumentDataMember="Hospital" ArgumentScaleType="Qualitative" Name="Compliance %" ValueDataMembersSerializable="Percentage_PMs">
                                        <viewserializable>
                                            <cc1:SideBySideBarSeriesView>
                                            </cc1:SideBySideBarSeriesView>
                                        </viewserializable>
                                        <labelserializable>
                                            <cc1:SideBySideBarSeriesLabel LineVisible="True" Antialiasing="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" TextColor="224, 224, 224">
                                                <border visible="False" /><fillstyle>
                                                    <optionsserializable>
                                                        <cc1:SolidFillOptions />
                                                    </optionsserializable>
                                                </fillstyle>
                                                <pointoptionsserializable>
                                                    <cc1:PointOptions Pattern="{V}%">
                                                        <argumentnumericoptions format="General" />
                                                        <valuenumericoptions format="Number" precision="1" />
                                                    </cc1:PointOptions>
                                                </pointoptionsserializable>
                                            </cc1:SideBySideBarSeriesLabel>
                                        </labelserializable>
                                        <legendpointoptionsserializable>
                                            <cc1:PointOptions Pattern="{V}%">
                                                <argumentnumericoptions format="General" />
                                                <valuenumericoptions format="Number" precision="1" />
                                            </cc1:PointOptions>
                                        </legendpointoptionsserializable>
                                    </cc1:Series>
                                </seriesserializable>
                                <seriestemplate>
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
                                </seriestemplate>

                                    <palettewrappers>
                                        <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                            <palette>
                                                <cc1:PaletteEntry Color="75, 75, 75" Color2="75, 75, 75" />
                                            </palette>
                                        </dxchartsui:PaletteWrapper>
                                    </palettewrappers>                    

                                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                                    </CommonLabelPositionSerializable>
                                    </CrosshairOptions>

                                    <ToolTipOptions><ToolTipPositionSerializable>
                                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                                    </ToolTipPositionSerializable>
                                    </ToolTipOptions>
                          </dxchartsui:WebChartControl>
                          <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="spS_Dashboard_Monthly_PM_History_ByHospital" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                      </div>
                      <div id="chrt1_detail" class="chart-body" runat="server">
                          <dxchartsui:WebChartControl ID="WebChartControl7" runat="server" DataSourceID="SqlDataSource7" Height="230px" Width="600px" BackColor="Transparent" PaletteName="Palette 1">
                            <borderoptions visible="False" />
                            <diagramserializable>
                                <cc1:XYDiagram>
                                    <axisx visibleinpanesserializable="-1">
                                        <label font="Calibri, 11pt" textcolor="75, 75, 75">
                                        </label>
                                        <range sidemarginsenabled="True" />
                                        <numericoptions format="General" />
                                    </axisx>
                                    <axisy visibleinpanesserializable="-1">
                                        <constantlines>
                                            <cc1:ConstantLine AxisValueSerializable="90" Color="Red" LegendText="Treshhold" Name="Treshhold">
                                            </cc1:ConstantLine>
                                        </constantlines>
                                        <label font="Calibri, 9pt" textcolor="75, 75, 75">
                                        </label>
                                        <range sidemarginsenabled="True" Auto="False" MaxValueSerializable="100" MinValueSerializable="0" />
                                        <gridlines color="224, 224, 224">
                                        </gridlines>
                                        <numericoptions format="General" />
                                    </axisy>
                                    <defaultpane backcolor="Transparent">
                                    </defaultpane>
                                </cc1:XYDiagram>
                            </diagramserializable>
                            <FillStyle><OptionsSerializable>
                            <cc1:SolidFillOptions></cc1:SolidFillOptions>
                            </OptionsSerializable>
                            </FillStyle>

                            <legend visible="False"></legend>

                            <seriesserializable>
                                <cc1:Series ArgumentDataMember="Month" ArgumentScaleType="Qualitative" Name="Series 1" ValueDataMembersSerializable="Percentage">
                                    <viewserializable>
                                        <cc1:SplineSeriesView>
                                            <linemarkeroptions visible="True">
                                            </linemarkeroptions>
                                        </cc1:SplineSeriesView>
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
                                    <cc1:SplineSeriesView>
                                        <linemarkeroptions visible="True">
                                        </linemarkeroptions>
                                    </cc1:SplineSeriesView>
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

                            <palettewrappers>
                                <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                    <palette>
                                        <cc1:PaletteEntry Color="102, 179, 255" Color2="102, 179, 255" />
                                    </palette>
                                </dxchartsui:PaletteWrapper>
                            </palettewrappers>

                            <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                            <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                            </CommonLabelPositionSerializable>
                            </CrosshairOptions>

                            <ToolTipOptions><ToolTipPositionSerializable>
                            <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                            </ToolTipPositionSerializable>
                            </ToolTipOptions>
                          </dxchartsui:WebChartControl>
                          <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" ProviderName="System.Data.SqlClient" SelectCommand="spS_Dashboard_Yearly_PM_History_PerHospital" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="hospital" Type="Int32" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                      </div>
                    </div><!-- END: CHART 1 -->

                    <!-- DIV: CHART 2 -->        
                    <div id="resize-chrt2" class="chart-container">                  
                      <header class="chart-header">
                        <h3>Monthly PM's</h3>
                        <p>Compliance <span><asp:Label ID="lblMonthlyPMCompliance2" runat="server" Text=""></asp:Label>%</span></p>
                      </header>                    
                      <div class="chart-body">
                        <dxchartsui:WebChartControl ID="WebChartControl4" runat="server" DataSourceID="SqlDataSource4" Height="230px" Width="295px" PaletteName="Palette 1" BackColor="Transparent" ClientInstanceName="WebChartControl4">
                                    <borderoptions visible="False" />
                                <diagramserializable>
                                    <cc1:XYDiagram>
                                        <axisx visibleinpanesserializable="-1">
                                            <label font="Calibri, 11pt">
                                            </label>
                                            <range sidemarginsenabled="True" />
                                            <numericoptions format="General" />
                                        </axisx>
                                        <axisy visibleinpanesserializable="-1">
                                            <label textcolor="75, 75, 75" font="Calibri, 9pt">
                                            </label>
                                            <range sidemarginsenabled="True" />
                                            <gridlines color="224, 224, 224">
                                            </gridlines>
                                            <numericoptions format="General" />
                                        </axisy>
                                        <defaultpane backcolor="Transparent">
                                        </defaultpane>
                                    </cc1:XYDiagram>
                                </diagramserializable>
                                <FillStyle><OptionsSerializable>
                                <cc1:SolidFillOptions></cc1:SolidFillOptions>
                                </OptionsSerializable>
                                </FillStyle>

                                    <legend alignmenthorizontal="Right" alignmentvertical="TopOutside" direction="LeftToRight" equallyspaceditems="False" visible="False"></legend>

                                <seriesserializable>
                        
                        
                                <cc1:Series ArgumentDataMember="Description1" ArgumentScaleType="Qualitative" Name="Assigned" ValueDataMembersSerializable="Assigned_PMs" LabelsVisibility="True">
                            
                            
                            
                                    <viewserializable>
                                
                                        <cc1:SideBySideBarSeriesView>
                                            </cc1:SideBySideBarSeriesView></viewserializable><labelserializable>
                                
                                        <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" Position="Center" TextColor="224, 224, 224">
                                    
                                    
                                            <border visible="False" /><fillstyle>
                                        
                                                <optionsserializable>
                                            
                                                    <cc1:SolidFillOptions /></optionsserializable></fillstyle><pointoptionsserializable>
                                        
                                                <cc1:PointOptions>
                                            
                                            
                                                    <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></pointoptionsserializable></cc1:SideBySideBarSeriesLabel></labelserializable><legendpointoptionsserializable>
                                
                                        <cc1:PointOptions>
                                    
                                    
                                            <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></legendpointoptionsserializable></cc1:Series><cc1:Series ArgumentDataMember="Description2" ArgumentScaleType="Qualitative" Name="Completed" ValueDataMembersSerializable="Completed_PMs" LabelsVisibility="True">
                            
                            
                            
                                    <viewserializable>
                                
                                        <cc1:SideBySideBarSeriesView>
                                            </cc1:SideBySideBarSeriesView></viewserializable><labelserializable>
                                
                                        <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" Position="Center" TextColor="25, 25, 25">
                                    
                                    
                                            <border visible="False" /><fillstyle>
                                        
                                                <optionsserializable>
                                            
                                                    <cc1:SolidFillOptions /></optionsserializable></fillstyle><pointoptionsserializable>
                                        
                                                <cc1:PointOptions>
                                            
                                            
                                                    <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></pointoptionsserializable></cc1:SideBySideBarSeriesLabel></labelserializable><legendpointoptionsserializable>
                                
                                        <cc1:PointOptions>
                                    
                                    
                                            <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></legendpointoptionsserializable></cc1:Series></seriesserializable>

                                    <SeriesTemplate argumentscaletype="Numerical"><ViewSerializable>
                                        <cc1:SideBySideBarSeriesView>
                                        </cc1:SideBySideBarSeriesView>
                                    </ViewSerializable>
                                    <LabelSerializable>
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
                                    </LabelSerializable>
                                    <LegendPointOptionsSerializable>
                                    <cc1:PointOptions>
                                    <ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

                                    <ValueNumericOptions Format="General"></ValueNumericOptions>
                                    </cc1:PointOptions>
                                    </LegendPointOptionsSerializable>
                                    </SeriesTemplate>

                                                    <palettewrappers>
                                                        <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                                            <palette>
                                                                <cc1:PaletteEntry Color="75, 75, 75" Color2="75, 75, 75" />
                                                                <cc1:PaletteEntry Color="102, 179, 255" Color2="102, 179, 255" />
                                                            </palette>
                                                        </dxchartsui:PaletteWrapper>
                                    </palettewrappers>

                                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                                    </CommonLabelPositionSerializable>
                                    </CrosshairOptions>

                                    <ToolTipOptions><ToolTipPositionSerializable>
                                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                                    </ToolTipPositionSerializable>
                                    </ToolTipOptions>
                        </dxchartsui:WebChartControl>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="spS_Dashboard_Monthly_PM_History" SelectCommandType="StoredProcedure" ProviderName="System.Data.SqlClient">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="hospital" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                      </div>                    
                    </div><!-- END: CHART 2 -->

                    <!-- DIV: CHART 3 -->        
                    <div id="resize-chrt3" class="chart-container">
                        <header class="chart-header">
                        <h3>YTD Priorities</h3>
                        <p>Compliance <span><asp:Label ID="lblYTDPriorityCompliance" runat="server" Text=""></asp:Label>%</span></p>
                        </header>
                        <div class="chart-body">
                        <dxchartsui:WebChartControl ID="WebChartControl5" runat="server" DataSourceID="SqlDataSource5" Height="230px" Width="295px" PaletteName="Palette 1" BackColor="Transparent" ClientInstanceName="WebChartControl5">
                                    <borderoptions visible="False" />
                                <diagramserializable>
                                    <cc1:XYDiagram>
                                        <axisx visibleinpanesserializable="-1">
                                            <label font="Calibri, 11pt" textcolor="75, 75, 75">
                                            </label>
                                            <range sidemarginsenabled="True" />
                                            <numericoptions format="General" />
                                        </axisx>
                                        <axisy visibleinpanesserializable="-1">
                                            <label textcolor="75, 75, 75" font="Calibri, 9pt">
                                            </label>
                                            <range sidemarginsenabled="True" />
                                            <gridlines color="224, 224, 224">
                                            </gridlines>
                                            <numericoptions format="General" />
                                        </axisy>
                                        <defaultpane backcolor="Transparent">
                                        </defaultpane>
                                    </cc1:XYDiagram>
                                </diagramserializable>
                                <FillStyle><OptionsSerializable>
                                <cc1:SolidFillOptions></cc1:SolidFillOptions>
                                </OptionsSerializable>
                                </FillStyle>

                                    <legend visible="False"></legend>

                                <seriesserializable>
                        
                        
                                <cc1:Series ArgumentDataMember="Description3" ArgumentScaleType="Qualitative" Name="Open WO" ValueDataMembersSerializable="Assigned_Priorities" LabelsVisibility="True">
                            
                            
                            
                                    <viewserializable>
                                
                                        <cc1:SideBySideBarSeriesView>
                                            </cc1:SideBySideBarSeriesView></viewserializable><labelserializable>
                                
                                        <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" Position="Center" TextColor="224, 224, 224">
                                    
                                    
                                            <border visible="False" /><fillstyle>
                                        
                                                <optionsserializable>
                                            
                                                    <cc1:SolidFillOptions /></optionsserializable></fillstyle><pointoptionsserializable>
                                        
                                                <cc1:PointOptions>
                                            
                                            
                                                    <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></pointoptionsserializable></cc1:SideBySideBarSeriesLabel></labelserializable><legendpointoptionsserializable>
                                
                                        <cc1:PointOptions>
                                    
                                    
                                            <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></legendpointoptionsserializable></cc1:Series><cc1:Series ArgumentDataMember="Description4" ArgumentScaleType="Qualitative" Name="Completed" ValueDataMembersSerializable="Completed_Priorities" LabelsVisibility="True">
                            
                            
                            
                                    <viewserializable>
                                
                                        <cc1:SideBySideBarSeriesView>
                                            </cc1:SideBySideBarSeriesView></viewserializable><labelserializable>
                                
                                        <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" Position="Center" TextColor="25, 25, 25">
                                    
                                    
                                            <border visible="False" /><fillstyle>
                                        
                                                <optionsserializable>
                                            
                                                    <cc1:SolidFillOptions /></optionsserializable></fillstyle><pointoptionsserializable>
                                        
                                                <cc1:PointOptions>
                                            
                                            
                                                    <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></pointoptionsserializable></cc1:SideBySideBarSeriesLabel></labelserializable><legendpointoptionsserializable>
                                
                                        <cc1:PointOptions>
                                    
                                    
                                            <argumentnumericoptions format="General" /><valuenumericoptions format="Number" precision="0" /></cc1:PointOptions></legendpointoptionsserializable></cc1:Series></seriesserializable>

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

                                                    <palettewrappers>
                                                        <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                                            <palette>
                                                                <cc1:PaletteEntry Color="75, 75, 75" Color2="75, 75, 75" />
                                                                <cc1:PaletteEntry Color="102, 179, 255" Color2="102, 179, 255" />
                                                            </palette>
                                                        </dxchartsui:PaletteWrapper>
                                    </palettewrappers>

                                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                                    </CommonLabelPositionSerializable>
                                    </CrosshairOptions>

                                    <ToolTipOptions><ToolTipPositionSerializable>
                                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                                    </ToolTipPositionSerializable>
                                    </ToolTipOptions>
                        </dxchartsui:WebChartControl>
                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="spS_Dashboard_Monthly_PM_History" SelectCommandType="StoredProcedure" ProviderName="System.Data.SqlClient">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="hospital" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </div>
                    </div><!-- END: CHART 3 -->                                                        
                    <!-- POPUP: POPHOSPITAL --> 
                    <dx:ASPxPopupControl ID="popHospital" runat="server" ClientInstanceName="popHospital" HeaderText="Hospital!" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AutoUpdatePosition="True" Width="350px">
                      <ContentCollection>
                        <dx:PopupControlContentControl ID="PopupControlContentControl1"  runat="server">
                            <table>
                                <tr>                                    
                                    <td style="vertical-align: middle;">
                                      <dx:ASPxComboBox ID="cmbHospital" runat="server" ValueType="System.String" ClientInstanceName="cmbHospital" AutoPostBack="True" OnSelectedIndexChanged="cmbHospital_SelectedIndexChanged" EnableSynchronization="False" IncrementalFilteringMode="Contains" OnLoad="cmbHospital_Load" RenderIFrameForPopupElements="True" HelpText="Select a Hospital..." Width="230px">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) { closePopUp(); }" /> </dx:ASPxComboBox>	                                                                                                                                                                                                                                         
                                    </td>
                                    <td style="width:10px;"></td>
                                    <td style="vertical-align: middle;"> <dx:ASPxButton ID="btnClosePopHospital" runat="server" Text="Close" Height="35px" Width="90px" Font-Size="0.91em" Theme="Metropolis" ClientInstanceName="btnClosePopHospital" AutoPostBack="False">
                                        <ClientSideEvents Click="closePopUp" /></dx:ASPxButton> 
                                    </td>    
                                </tr>
                            </table>                                                            
                        </dx:PopupControlContentControl>
                      </ContentCollection>
                    </dx:ASPxPopupControl>
                  </ContentTemplate>
                </asp:UpdatePanel>

                <!-- DIV: CHART 4 -->
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" OnLoad="UpdatePanel3_Load">
                  <ContentTemplate>                 
                    <div id="resize-chrt4" class="chart-container slider">
                        <header class="chart-header">
                          <div class="chart-img">
                            <dx:ASPxBinaryImage ID="ASPxBinaryImage1" runat="server" Height="40px" Width="40px">
                                <EmptyImage Url="~/Images/User.jpg">
                                </EmptyImage>
                            </dx:ASPxBinaryImage>
                          </div>
                          <h3> <dx:ASPxLabel ID="lblUserName" runat="server"><ClientSideEvents Click="function(s, e) { popUser.Show(); }" /> </dx:ASPxLabel> </h3>
                          <p>BMET Compliance <span><asp:Label ID="lblUserOverall" CssClass="overall" runat="server"></asp:Label>%</span><dx:ASPxLabel ID="lblTools2" runat="server" CssClass="entypo-tools">
                              <ClientSideEvents Click="function(s, e) {
var id = document.getElementById('hdn_bmetid').value;
	                                                                    popBmetDetail.SetContentUrl(&quot;../bmet_section/bmet_detail.aspx?UID=&quot; + id);
	                                                                    popBmetDetail.Show();
                                                                    }" /> </dx:ASPxLabel>
                          </p>
                        </header>
                        <div class="chart-body">
                        <!-- DIV: two-chrts 1 -->
                        <div id="two-chrts-rsz1" class="two-chrts">
                            <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" DataSourceID="SqlDataSource1" Height="230px" PaletteName="Palette 1" Width="300px" BackColor="Transparent">
                                    <emptycharttext text="." />
                                    <borderoptions visible="False" />
                                    <diagramserializable>
                                        <cc1:XYDiagram>
                                            <axisx visibleinpanesserializable="-1">
                                                <label font="Calibri, 9pt" textcolor="75, 75, 75"></label><range sidemarginsenabled="True" />
                                                <numericoptions format="General" />
                                            </axisx>
                                            <axisy visibleinpanesserializable="-1" interlacedcolor="224, 224, 224">
                                                <label textcolor="75, 75, 75" font="Calibri, 9pt">
                                                </label>
                                                <range sidemarginsenabled="True" />
                                                <gridlines color="224, 224, 224">
                                                </gridlines>
                                                <numericoptions format="General" />
                                            </axisy>
                                            <defaultpane backcolor="Transparent">
                                            </defaultpane>
                                        </cc1:XYDiagram>
                                    </diagramserializable>
                                    <FillStyle><OptionsSerializable>
                                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                                    </OptionsSerializable>
                                    </FillStyle>
                                    <legend visible="False"></legend>
                                    <seriesserializable>
                                        <cc1:Series ArgumentScaleType="Qualitative" Name="Assigned" ValueDataMembersSerializable="Assigned_PMs" LabelsVisibility="True" ArgumentDataMember="Description1">
                                            <viewserializable>
                                                <cc1:SideBySideBarSeriesView>
                                                </cc1:SideBySideBarSeriesView>
                                            </viewserializable>
                                            <labelserializable>
                                                <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" Position="Center" TextColor="224, 224, 224">
                                                    <border visible="False" /><fillstyle>
                                                        <optionsserializable>
                                                            <cc1:SolidFillOptions />
                                                        </optionsserializable>
                                                    </fillstyle>
                                                    <pointoptionsserializable>
                                                        <cc1:PointOptions>
                                                            <argumentnumericoptions format="General" />
                                                            <valuenumericoptions format="Number" precision="0" />
                                                        </cc1:PointOptions>
                                                    </pointoptionsserializable>
                                                </cc1:SideBySideBarSeriesLabel>
                                            </labelserializable>
                                            <legendpointoptionsserializable>
                                                <cc1:PointOptions>
                                                    <argumentnumericoptions format="General" />
                                                    <valuenumericoptions format="Number" precision="0" />
                                                </cc1:PointOptions>
                                            </legendpointoptionsserializable>
                                        </cc1:Series>
                                        <cc1:Series ArgumentScaleType="Qualitative" Name="Completed" ValueDataMembersSerializable="Completed_PMs" LabelsVisibility="True" ArgumentDataMember="Description2">
                                            <viewserializable>
                                                <cc1:SideBySideBarSeriesView>
                                                </cc1:SideBySideBarSeriesView>
                                            </viewserializable>
                                            <labelserializable>
                                                <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" Position="Center" TextColor="25, 25, 25">
                                                    <fillstyle>
                                                        <optionsserializable>
                                                            <cc1:SolidFillOptions />
                                                        </optionsserializable>
                                                    </fillstyle>
                                                    <pointoptionsserializable>
                                                        <cc1:PointOptions>
                                                            <argumentnumericoptions format="General" />
                                                            <valuenumericoptions format="Number" precision="0" />
                                                        </cc1:PointOptions>
                                                    </pointoptionsserializable>
                                                </cc1:SideBySideBarSeriesLabel>
                                            </labelserializable>
                                            <legendpointoptionsserializable>
                                                <cc1:PointOptions>
                                                    <argumentnumericoptions format="General" />
                                                    <valuenumericoptions format="Number" precision="0" />
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
                                        <cc1:ChartTitle Font="Calibri, 15pt" Text="Monthly PM's" TextColor="75, 75, 75" />
                                    </titles>
                                    <palettewrappers>
                                        <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                            <palette>
                                                <cc1:PaletteEntry Color="75, 75, 75" Color2="75, 75, 75" />
                                                <cc1:PaletteEntry Color="102, 179, 255" Color2="102, 179, 255" />
                                            </palette>
                                        </dxchartsui:PaletteWrapper>
                                    </palettewrappers>
                                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                                    </CommonLabelPositionSerializable>
                                    </CrosshairOptions>

                                    <ToolTipOptions><ToolTipPositionSerializable>
                                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                                    </ToolTipPositionSerializable>
                                    </ToolTipOptions>
                                </dxchartsui:WebChartControl>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" ProviderName="System.Data.SqlClient" SelectCommand="spS_Report_BMET_Monthly_PM_History" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="" Name="UserID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div><!-- END: two-chrts 1 -->
                        <!-- DIV: two-chrts 2 -->                
                        <div id="two-chrts-rsz2" class="two-chrts">
                            <dxchartsui:WebChartControl ID="WebChartControl2" runat="server" BackColor="Transparent" DataSourceID="SqlDataSource2" Height="230px" PaletteName="Palette 1" Width="420px">
                                    <emptycharttext text="." />
                                    <borderoptions visible="False" />
                                    <diagramserializable>
                                        <cc1:XYDiagram>
                                            <axisx visibleinpanesserializable="-1">
                                                <label font="Calibri, 9pt" textcolor="75, 75, 75"></label><range sidemarginsenabled="False" />
                                                <numericoptions format="General" />
                                            </axisx>
                                            <axisy visibleinpanesserializable="-1">
                                                <label textcolor="75, 75, 75" font="Calibri, 9pt">
                                                </label>
                                                <range sidemarginsenabled="True" />
                                                <gridlines color="224, 224, 224">
                                                </gridlines>
                                                <numericoptions format="General" />
                                            </axisy>
                                            <defaultpane backcolor="Transparent">
                                            </defaultpane>
                                        </cc1:XYDiagram>
                                    </diagramserializable>
                                    <FillStyle><OptionsSerializable>
                                    <cc1:SolidFillOptions></cc1:SolidFillOptions>
                                    </OptionsSerializable>
                                    </FillStyle>

                                    <legend visible="False"></legend>
                                    <seriesserializable>
                                        <cc1:Series ArgumentDataMember="Month" ArgumentScaleType="Qualitative" Name="Series 1" ValueDataMembersSerializable="Percentage">
                                            <viewserializable>
                                                <cc1:AreaSeriesView>
                                                    <markeroptions visible="True">
                                                    </markeroptions>
                                                </cc1:AreaSeriesView>
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
                                            <cc1:AreaSeriesView Transparency="0">
                                                <markeroptions visible="True">
                                                </markeroptions>
                                            </cc1:AreaSeriesView>
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
                                        <cc1:ChartTitle Font="Calibri, 15pt" Text="Monthly Compliance %" TextColor="75, 75, 75" />
                                    </titles>
                                    <palettewrappers>
                                        <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                            <palette>
                                                <cc1:PaletteEntry Color="75, 75, 75" Color2="75, 75, 75" />
                                            </palette>
                                        </dxchartsui:PaletteWrapper>
                                    </palettewrappers>

                                    <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                                    <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                                    </CommonLabelPositionSerializable>
                                    </CrosshairOptions>

                                    <ToolTipOptions><ToolTipPositionSerializable>
                                    <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                                    </ToolTipPositionSerializable>
                                    </ToolTipOptions>
                                </dxchartsui:WebChartControl>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" ProviderName="System.Data.SqlClient" SelectCommand="spS_Report_BMET_Yearly_PM_History" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="" Name="UserID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div><!-- END: two-chrts 2 -->
                                                
                        <!-- SLIDER ARROWS -->
                        <div id="left_arrow"><dx:ASPxLabel ID="ASPxLabel2" CssClass="entypo-reply" runat="server">
                            <ClientSideEvents Click="function(s, e) { leftArrow(); }" /></dx:ASPxLabel></div>
                        <div id="right_arrow"><dx:ASPxLabel ID="ASPxLabel3" CssClass="entypo-forward" runat="server">
                            <ClientSideEvents Click="function(s, e) { rightArrow(); }" /></dx:ASPxLabel></div>

                      </div>                  
                    </div><!-- END: CHART 4 -->
                    <dx:ASPxPopupControl ID="popUser" runat="server" ClientInstanceName="popUser" HeaderText="User" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AutoUpdatePosition="True" Width="350px">
                      <ContentCollection>
                        <dx:PopupControlContentControl ID="PopupControlContentControl2"  runat="server">
                            <table>
                                <tr>                                    
                                    <td style="vertical-align: middle;">
                                      <dx:ASPxComboBox ID="cmbUser" runat="server" ValueType="System.String" ClientInstanceName="cmbUser" AutoPostBack="True" OnSelectedIndexChanged="cmbUser_SelectedIndexChanged" EnableSynchronization="False" IncrementalFilteringMode="Contains" OnLoad="cmbUser_Load" RenderIFrameForPopupElements="True" HelpText="Select a User..." Width="230px">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) { closePopUp(); }" /> </dx:ASPxComboBox>	                                                                                                                                                                                                                                         
                                    </td>
                                    <td style="width:10px;"></td>
                                    <td style="vertical-align: middle;"> <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Close" Height="35px" Width="90px" Font-Size="0.91em" Theme="Default" ClientInstanceName="btnClosePopHospital" AutoPostBack="False">
                                        <ClientSideEvents Click="closePopUp" /></dx:ASPxButton> 
                                    </td>    
                                </tr>
                            </table>                                                            
                        </dx:PopupControlContentControl>
                      </ContentCollection>
                    </dx:ASPxPopupControl>
                    <!-- HIDDEN FIELDS - BMET ID-->
                    <asp:HiddenField ID="hdn_bmetid" runat="server"/>
                 </ContentTemplate>
                </asp:UpdatePanel>

                <!-- DIV: CHART 5 -->        
                <div id="resize-chrt5" class="chart-container">
                  <header class="chart-header">
                    <h3>Open WO & Parts</h3>
                    <p>Total <span><asp:Label ID="lblPendingPickUp2" CssClass="overall" runat="server" Text=""></asp:Label></span></p>
                  </header>
                  <div class="chart-body">
                    <dxchartsui:WebChartControl ID="WebChartControl6" runat="server" Height="230px" Width="470px" PaletteName="Palette 1" BackColor="Transparent" DataSourceID="SqlDataSource6">
                                <borderoptions visible="False" />
                            <diagramserializable>
                                <cc1:XYDiagram>
                                    <axisx visibleinpanesserializable="-1">
                                        <label font="Calibri, 11pt" angle="-90" textcolor="75, 75, 75">
                                        </label>
                                        <range sidemarginsenabled="True" />
                                        <numericoptions format="General" />
                                    </axisx>
                                    <axisy visibleinpanesserializable="-1">
                                        <label textcolor="75, 75, 75" font="Calibri, 9pt">
                                        </label>
                                        <range sidemarginsenabled="True" />
                                        <gridlines color="224, 224, 224">
                                        </gridlines>
                                        <numericoptions format="General" />
                                    </axisy>
                                    <defaultpane backcolor="Transparent">
                                    </defaultpane>
                                </cc1:XYDiagram>
                            </diagramserializable>
                            <FillStyle><OptionsSerializable>
                            <cc1:SolidFillOptions></cc1:SolidFillOptions>
                            </OptionsSerializable>
                            </FillStyle>

                                <legend visible="False"></legend>

                            <seriesserializable>
                                <cc1:Series ArgumentDataMember="Hospital" ArgumentScaleType="Qualitative" Name="Hospitals" ValueDataMembersSerializable="Counter" LabelsVisibility="True">
                                    <viewserializable>
                                        <cc1:SideBySideBarSeriesView>
                                        </cc1:SideBySideBarSeriesView>
                                    </viewserializable>
                                    <labelserializable>
                                        <cc1:SideBySideBarSeriesLabel LineVisible="True" BackColor="Transparent" Font="Verdana, 10pt, style=Bold" TextColor="224, 224, 224">
                                            <border visible="False" /><fillstyle>
                                                <optionsserializable>
                                                    <cc1:SolidFillOptions />
                                                </optionsserializable>
                                            </fillstyle>
                                            <pointoptionsserializable>
                                                <cc1:PointOptions>
                                                    <argumentnumericoptions format="General" />
                                                    <valuenumericoptions format="Number" precision="0" />
                                                </cc1:PointOptions>
                                            </pointoptionsserializable>
                                        </cc1:SideBySideBarSeriesLabel>
                                    </labelserializable>
                                    <legendpointoptionsserializable>
                                        <cc1:PointOptions>
                                            <argumentnumericoptions format="General" />
                                            <valuenumericoptions format="Number" precision="0" />
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

                                                <palettewrappers>
                                                    <dxchartsui:PaletteWrapper Name="Palette 1" ScaleMode="Repeat">
                                                        <palette>
                                                            <cc1:PaletteEntry Color="75, 75, 75" Color2="75, 75, 75" />
                                                            <cc1:PaletteEntry Color="102, 179, 255" Color2="102, 179, 255" />
                                                        </palette>
                                                    </dxchartsui:PaletteWrapper>
                                </palettewrappers>

                                <CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
                                <cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
                                </CommonLabelPositionSerializable>
                                </CrosshairOptions>

                                <ToolTipOptions><ToolTipPositionSerializable>
                                <cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
                                </ToolTipPositionSerializable>
                                </ToolTipOptions>
                    </dxchartsui:WebChartControl>
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CiracetNewConnectionString %>" SelectCommand="Select h.InicialesHospital As 'Hospital', Count(w.id) As 'Counter'
                        From  WorkOrder w Inner Join
                            Hospital h On w.idHospital = h.idInstitucion Inner Join
                            QuotationHeader qh On w.id = qh.WorkOrderId Inner Join
                            Parte p On qh.ParteID = p.iD
                        Where qh.Status = 7   
                        Group By h.InicialesHospital
                        Order By h.InicialesHospital">
                    </asp:SqlDataSource>
                  </div>
                </div><!-- END: CHART 5 -->                                 
              </section><!-- END: SECTION2 -->                
            </ContentTemplate>
          </asp:UpdatePanel>
        </div><!-- END: WRAP -->

        <!--POPUP WINDOWS-->
        <dx:ASPxPopupControl ID="popBmetDetail" runat="server" ClientInstanceName="popBmetDetail" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Height="768px" Width="1202px" HeaderText="User Detail"></dx:ASPxPopupControl>
      
        <!-- HIDDEN FIELDS - SCREEN WIDTH-->
        <asp:HiddenField ID="hidden_screenwidth" runat="server" Value="0"/>

        <!-- HIDDEN FIELDS - CHART SIZE--> 
        <asp:HiddenField ID="hidden_chrt1Width" runat="server" />
        <asp:HiddenField ID="hidden_chrt2Width" runat="server" />
        <asp:HiddenField ID="hidden_chrt3Width" runat="server" />
        <asp:HiddenField ID="hidden_chrt4Width" runat="server"/>
        <asp:HiddenField ID="hidden_rsz1" runat="server" />
        <asp:HiddenField ID="hidden_rsz2" runat="server"/>
        <asp:HiddenField ID="hidden_chrt5Width" runat="server"/>

        <!-- HIDDEN FIELDS - BMET INDEX-->
        <asp:HiddenField ID="hdn_index" runat="server" Value="0"/>
      

    </form>
</body>
</html>
