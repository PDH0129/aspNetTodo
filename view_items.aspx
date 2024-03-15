<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_items.aspx.cs" Inherits="TodoList.view_items" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 130px auto 196px; width: 800px; height: 800px; display: flex;">
            <div class="list_items" style="border-top: 2px solid #FFDA47; border-right: 3px solid #FFDA47; border-bottom: 4px solid #FFDA47; border-left: 2px solid #FFDA47; border-radius: 16px; width: 600px; height: 700px; margin: auto auto auto auto;">
                <asp:Label ID="Label1" runat="server" Text="list" CssClass="lable"></asp:Label>

                <asp:DataGrid ID="lits_items" runat="server" Width="600px" Height="700px" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundColumn DataField="할 일" HeaderText="할 일" HeaderStyle-Height="60px">
                            <HeaderStyle Width="300px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        </asp:BoundColumn>

                        <asp:TemplateColumn HeaderText="완료" HeaderStyle-Width="30px" HeaderStyle-Height="20px">
                            <ItemTemplate>
                                <asp:CheckBox ID="isSucceed" runat="server" Checked='<%# Eval("성취도") %>' AutoPostBack="true" OnCheckedChanged="isSucceed_CheckedChanged" />
                            </ItemTemplate>
                        </asp:TemplateColumn>

                    </Columns>
                    <HeaderStyle CssClass="grid-header" />
                </asp:DataGrid>

                <asp:Button runat="server" ID="btnreturn" Text="돌아가기" CssClass="returnbtn" OnClick="btnreturn_Click" />
            </div>
        </div>

        <div class="btnShares">
            <asp:Label runat="server" Text="공유하기: " CssClass="sharelbl1" Width="110px" Height="27px" />
            <asp:Label ID="lblLink" CssClass="sharelbl2" runat="server" Text="https://pdh.jlink.kr/view_items.aspx?id="></asp:Label>
        </div>
    </form>

    <style>
        .lable {
            position: absolute;
            margin: -35px auto auto 20px;
            font-size: 45px;
            background: white;
        }

        .grid-header {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: bold;
        }

        .returnbtn {
            margin-top: 40px;
            margin-left: 35%;
            margin-right: 35px;
            width: 140px;
            height: 50px;
            font-size: 20px;
            background: #0C1021;
            color: #005B40;
            border: 2px solid #B29143;
        }

            .returnbtn:hover {
                background: black;
                color: #B58D00;
            }

        .sharelbl1 {
            /*border: 1px solid black;*/
            font-size: 23px;
            font-style: italic;
            font-family: Arial;
        }

            .sharelbl1:hover {
                color: #E0F900;
            }

        .btnShares {
            text-align: center;
            align-content: space-between;
            align-content: center;
        }

        .sharelbl2 {
            border: 2px solid black;
            margin-left: 16px;
            font-size: 22px;
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }
    </style>
</body>
</html>
