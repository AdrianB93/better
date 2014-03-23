<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: ViewBag.character.name %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="monsterInfo">
        <div class="miLeft">
            <img src="../../images/characters/<%: ViewBag.character.imageFileName %>" />
        </div>
        <div class="miRight">
            <a href="../../characters/" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
            <div class="clearfix" style="margin-bottom: 20px;"></div>
            <h2><%: ViewBag.character.name %></h2>
            <div class="" style="margin: auto; width: 65%;">
                <p><span class="characterHeader">XP:</span> <span class="textboxAlign2"><%: ViewBag.character.xp %></span></p>
                <p><span class="characterHeader">ELEMENT:</span> <span class="textboxAlign2"><%: ViewBag.character.fixedCharacter.element.name %></span></p>
                <p><span class="characterHeader">BORN:</span> <span class="textboxAlign2"><%: ViewBag.character.birth %></span></p>
                <p><span class="characterHeader">LEVEL:</span> <span class="textboxAlign2"><%: ViewBag.character.level %></span></p>
                <p><span class="characterHeader">STEP:</span> <span class="textboxAlign2"><%: ViewBag.character.step %></span></p>
                <p><span class="characterHeader">WINS:</span> <span class="textboxAlign2"><%: ViewBag.character.wins.Count %></span></p>
                <p><span class="characterHeader">LOSSES:</span> <span class="textboxAlign2"><%: ViewBag.character.losses.Count %></span></p>
                <p><span class="characterHeader">OWNER:</span> <span class="textboxAlign2"><a href="#"><%: ViewBag.character.owner.username %></a></span></p>
                <% if (BetterWebApp.BetterSession.Current.user != null) { %>
                    <% if (ViewBag.character.owner.id != BetterWebApp.Models.Utilities.users[BetterWebApp.BetterSession.Current.user.id - 1].id) { // I am not this characters owner %>
                    <p><a href="/characters/<%: ViewBag.id %>/combat/new" class="button"><span>Battle Character</span></a></p>
                    <% } %>
                    <% else { %>
                    <script type="text/javascript">
                        // NOTE TO SELF, JQUERY IS LOADED FROM GOOGLE
                        function deleteCharacter() {
                            $.ajax({
                                url: '/characters/<%: ViewBag.id %>',
                                type: 'DELETE',
                                success: function (response) { alert("It worked."); }
                            });
                        }
                    </script>
                    <a href="#" class="button" onclick="alert('PUT and DELETE requests need to be AJAX\'d');">Delete Character</a>
                    <% } %>
                <% } %>
            </div>
        </div>
        <div class="clearfix"></div>
        <p>&nbsp;</p>
    </div>

</asp:Content>