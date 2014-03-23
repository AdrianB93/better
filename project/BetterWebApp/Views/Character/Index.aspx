    <%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Characters
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

    <h1>CHARACTERS</h1>
    <div class="centerMaker createNewButton" style="width: 55%; margin-top: 20px;">
        <p><a href="/character/new" class="newCharbutton"><span>Create New Character</span></a></p>
    </div>
    <div class="centerMaker createNewButton" style="width: 55%; margin-top: 0px;">
        <p><a href="/halloffame" class="newCharbutton"><span>Hall of Fame</span></a></p>
    </div>
    
    <div class="tableHolder">
    <table class="centerMaker sortable">
        <tr>
            <th class="sortTH">Name</th>
            <th class="sortTH">Level</th>
            <th class="sorttable_nosort">View</th>
        </tr>
      
        <% foreach (BetterWebApp.Models.UserCharacter uc in ViewBag.characters) { %>
                <tr class="display-table-tr">
                <td class="td-character-1"><%: uc.name %></td>
                <td class="td-character-2"><%: uc.level %>-<%: uc.step %></td>
                <td class="td-character-3"><a href="/characters/<%: uc.id %>">View Monster</a></td>
                </tr>
        <% } %>
    </table>
        </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <% if (ViewBag.error) { %>
    <h1>ERROR</h1>
    <p style="text-align: center;"><%: ViewBag.errorMsg %></p>
    <% } %>
    <% if (ViewBag.success) { %>
    <h1>SUCCESS</h1>
    <p style="text-align: center;"><%: ViewBag.successMsg %></p>
    <% } %>
</asp:Content>
