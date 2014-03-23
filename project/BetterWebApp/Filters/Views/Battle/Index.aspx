<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Battles
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
        <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>
    <h1>YOUR BATTLES</h1>
    <div class="tableHolder">
        <table class="centerMaker">
            <tr>
                <th>Date</th>
                <th>Challenger</th>
                <th>Opponent</th>
                <th>Winner</th>
                <th>View</th>
            
            </tr>
            <% foreach(BetterWebApp.Models.Battle b in ViewBag.yourBattles) { %>
            <tr class="display-table-tr">
                <td class="td-character-5"><%: b.date %></td>
                <td class="td-character-2"><%: b.challenger.name %></td>
                <td class="td-character-2"><%: b.opponent.name %></td>
                <td class="td-character-2"><%: b.winner.name %></td>
                <td class="td-character-2"><a href="/battles/<%: b.id %>">View Battle</a></td>
            </tr>
            <% } %>
        </table>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
