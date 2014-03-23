<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<BetterWebApp.Models.LoginModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    User Accounts
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="users">
           <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>
        
        <h1>Users:</h1>
        

        <div class="tableHolder">
        <table class="centerMaker sortable">
            <tr>
            <th class="sortTH">Screen Name</th>
                <th class="sortTH">Level</th>
            <th class="sorttable_nosort">View</th>

            </tr>
             <% for (int i = 0; i < ViewBag.users.Length; i++) { %>
                <tr class="display-table-tr">
                <td class="td-character-1"><%: ViewBag.users[i].username %></td>
                <td class="td-character-2"><%: (ViewBag.users[i].totalXP)/1500 + 1%></td>
                <td class="display-table-td2"><a href="players/<%: i + 1 %>">View Profile</a></td>
                </tr>
        <% } %>
    
        
        </table>
</div>
    </section>
</asp:Content>

