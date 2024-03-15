<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="listPage.aspx.cs" Inherits="TodoList.listPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <a href="https://www.google.com" target="_blank" style="text-decoration: none; color: red;" id="test" runat="server"></a>
        <div style="margin: 130px auto 196px; border: 2px solid black; width: 1003px; height: 800px; display: flex; overflow: auto;">
            <div class="taking_todolist">
                <asp:DataGrid ID="lists_list" runat="server" Height="800px" Width="180px" AutoGenerateColumns="false">
                    <HeaderStyle Font-Size="25px" BackColor="Black" ForeColor="White" Width="40px" Height="20px" />
                    <ItemStyle BackColor="#0A5B00" />
                    <FooterStyle ForeColor="#333333" BackColor="White"></FooterStyle>

                    <Columns>
                        <asp:TemplateColumn HeaderText="할일들" HeaderStyle-CssClass="customHeaderStyle2">
                            <itemtemplate>
                                <a href='<%# "view_items.aspx?id=" + Eval("id") %>' class="itemFont" id ="hyperlink" runat="server">
                                    <%# Eval("tltle") %>
                                </a>
                            </itemtemplate>
                        </asp:TemplateColumn>


                        <asp:TemplateColumn HeaderText="제거" HeaderStyle-CssClass="customHeaderStyle">
                            <ItemTemplate>
                                <asp:Button ID="btnDel" runat="server" CssClass="delBtn" Text="X" OnClick="btnDel_Click"/>
                            </ItemTemplate> 
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </div>

            <div class="list_items" style="border-top: 2px solid #FFDA47; border-right: 3px solid #FFDA47; border-bottom: 4px solid #FFDA47; border-left: 2px solid #FFDA47; border-radius: 16px; width: 600px; height: 700px; margin: auto auto auto auto;">
                <asp:Label ID="Label1" runat="server" Text="To-Do" CssClass="lable"></asp:Label>
                <div class="tinput">

                    <div class="put_title">
                        <asp:Label ID="Label2" runat="server" Text="할일 명" CssClass="lblname"></asp:Label><asp:TextBox ID="TextBox1" runat="server" CssClass="txtname"></asp:TextBox>
                    </div>

                    <div class="put_listitems">
                        <asp:ListBox runat="server" ID="lb_items" CssClass="work_list"></asp:ListBox>
                    </div>

                    <div class="put_work">
                        <asp:Label ID="Label3" runat="server" Text="할일 목록" CssClass="lblwork"></asp:Label>
                        <asp:TextBox ID="txt_newitem" runat="server" CssClass="txtwork"></asp:TextBox><asp:Button ID="btnAdd" runat="server" Text="추가" CssClass="btnwork" OnClick="btnAdd_Click" />
                    </div>

                    <div class="put_importance">
                        <asp:Label ID="Label4" runat="server" Text="중요도" CssClass="lblimportance"></asp:Label><input type="range" id="slider" min="1" max="10" step="1" runat="server" class="importance" />
                        <asp:Button runat="server" ID="btnFinish" Text="완료" CssClass="btnfini" OnClick="btnFinish_Click" />
                    </div>
                </div>

                <style>
                    .customHeaderStyle {
                        font-size: 16px;
                    }

                    .customHeaderStyle2 {
                        margin-right: 40px;
                    }

                    .itemFont {
                        text-decoration: none;
                        color: orange;
                        font-size: 20px;
                        padding: 5px 10px;
                        /*border: 2px dashed black;*/
                    }

                    .delBtn {
                        margin: 5px;
                        margin-left: 20px;
                        width: 25px;
                        height: 25px;
                        font-size: 8px;
                        background: #E05053;
                        border: 1px dotted black;
                        border-radius: 25px;
                        color: black;
                        text-align: center;
                    }

                    .lable {
                        position: absolute;
                        margin: -35px auto auto 20px;
                        font-size: 40px;
                        background: white;
                    }

                    .tinput {
                        margin-top: 20px;
                        /*border: 2px solid red;*/
                        width: 600px;
                    }

                    .put_title {
                        display: flex;
                        text-align: center;
                        font-size: 36px;
                        /*border: 2px solid black;*/
                    }

                    .lblname {
                        margin-right: 60px;
                        margin-left: 30px;
                    }

                    .txtname {
                        width: 300px;
                        border: 2px outset black;
                    }

                    .put_listitems {
                        /*border: 3px solid blue;*/
                        text-align: center;
                    }

                    .work_list {
                        margin-top: 20px;
                        margin-bottom: 20px;
                        height: 450px;
                        width: 500px;
                        font-size: 30px;
                    }

                    .put_work {
                        display: flex;
                        font-size: 24px;
                        margin-top: 20px;
                        padding-bottom: 15px;
                        border-bottom: 2px groove black;
                    }

                    .lblwork {
                        margin-right: 150px;
                        margin-left: 35px
                    }

                    .txtwork {
                        margin-right: 30px;
                    }

                    .put_importance {
                        display: flex;
                        margin-top: 15px;
                    }

                    .lblimportance {
                        margin-right: 50px;
                        margin-left: 30px
                    }

                    /*.importance{
                        margin-right
                    }*/

                    .btnfini {
                        margin-right: 30px;
                        margin-left: 230px;
                        width: 60px;
                        height: 40px;
                    }
                </style>
            </div>
        </div>
    </form>
</body>
</html>
