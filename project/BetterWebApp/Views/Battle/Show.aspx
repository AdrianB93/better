<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Show
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/battles" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>

    <h1 style="text-transform: uppercase;"><%: ViewBag.battle.challenger.name %> vs <%: ViewBag.battle.opponent.name %></h1>
    <div style="width: 50%; margin: 0 auto;">
        <img src="../../images/characters/<%: ViewBag.battle.challenger.imageFileName %>" style="width: 49%" />
        <img src="../../images/characters/<%: ViewBag.battle.opponent.imageFileName %>" style="width: 49%" />
    </div>
    
    <div style="width: 50%; margin: 0 auto;">
        <div class="clearfix" style="margin-bottom: 70px;"></div>
        <h2 style="text-align: center;">Battle Summary</h2>
        <h2 style="text-align: center; color: red;"><%: ViewBag.win %></h2>
        <div class="" style="margin: auto; width: 65%;">
            <p><span class="characterHeader">CHALLENGER:</span> <span class="textboxAlign2"><%: ViewBag.battle.challenger.name %></span></p>
            <p><span class="characterHeader">OPPONENT:</span> <span class="textboxAlign2"><%: ViewBag.battle.opponent.name %></span></p>
            <p><span class="characterHeader">XP GAINED:</span> <span class="textboxAlign2"><%: ViewBag.yourXp %></span></p>
        </div>
        <div class="clearfix" style="margin-bottom: 70px;"></div>
    </div> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
