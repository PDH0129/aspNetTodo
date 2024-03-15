<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logIN.aspx.cs" Inherits="TodoList.logIN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       

        <div style="margin: 530px auto 196px; border: 1px solid black; border-radius: 16px; /*border-bottom-left-radius: 200px; border-top-right-radius: 200px;*/ transform: rotate(-15deg); width: 800px; height: 500px;">
            <table style="">
                <tr>
                    <td style="display: flex; margin-top: 110px; margin-left: 50px;">
                        <h1 style="margin: 5px 120px 5px 4px">메일</h1>
                        <asp:TextBox ID="txtmail" runat="server" Font-Size="Large" Height="76px" Width="400px" TextMode="Email"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="* 메일형식이 올바르지 않습니다" ControlToValidate="txtmail" Display="None" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>

                <tr style="margin-top: 40px;">
                    <td style="display: flex; margin-top: 110px; margin-left: 50px;">
                        <h1 style="margin: 5px 50px 5px 4px">비밀번호</h1>
                        <asp:TextBox ID="txtpwd" runat="server" Font-Size="Large" Height="76px" Width="400px" TextMode="Password" EnableViewState="False"></asp:TextBox>
                    </td>
                </tr>
            </table>

            <div style="display: flex; margin: 30px auto auto">
                <asp:Button ID="btnIn" runat="server" Width="141px" Text="로그인" Font-Size="Large" Height="57px" CssClass="signIn" OnClick="btnIn_Click" />
                <asp:Button ID="btnUp" runat="server" AutoPostBack="true" Width="161px" Text="회원가입및 로그인" Font-Size="Large" Height="57px" CssClass="signUp" OnClick="btnUp_Click" />

                <style>
                    body {
                        background-image: url('https://pdh.jlink.kr/todoList_images/patricTodo.png');
                        background-size: cover;
                        /* 배경 이미지가 가운데 정렬되도록 설정 */
                        background-position: center;
                    }

                    .signIn {
                        margin-left: 390px;
                        margin-right: 40px;
                        margin-top: 10px;
                    }

                    .signUp {
                        margin: 10px 40px auto 20px;
                    }
                </style>
            </div>
        </div>
    </form>

</body>
</html>
