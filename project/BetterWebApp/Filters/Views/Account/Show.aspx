<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<BetterWebApp.Models.LoginModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    User Accounts
</asp:Content>

<asp:Content  ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    
    
    <section id="users">
     
  
   <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/players" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>

<div class="profileHolder">

<div class="myHeader">


<div id="mylefttext">
<div id="myUserHeading">
<h1 class="userHeading"> <%: ViewBag.users.username %> </h1>
</div>
<div id="myMemberSince">
<p class="memberParagraph"> Member Since: <%: ViewBag.users.registrationDate %></p>
</div>
</div>

<div class="XPHolder">
<h2 id="XPLabel">Total XP:</h2>
<h2 id="XPAmount"> <%: ViewBag.users.exerciseXP %> </h2>
</div>
</div>
    
<h1>Monsters:</h1>
    <%int i = 0; %>
    <% foreach (BetterWebApp.Models.UserCharacter uc in ViewBag.usersCharacters) { %>
    <div class="monsterholder">
<div class="monsterDisplay">
    <img src="/images/characters/<%: uc.imageFileName %>" class="monsterImage" />
    <p><%: uc.name %></p>
    <p><%: uc.xp %></p>
    <p class="mybuttontext"><a href="../characters/<%: uc.id %>" class="mybutton"><span class="battletext">View</span></a></p>
   </div>
        <%i++; %>
     <% } %>
        
    <% while (i < 4) { %>
       
            <div class="monsterholder">
            <div class="monsterDisplay">
             <img src="/images/characters/defaultImage.png" class="monsterImage" />
                <p>No Monster</p>
            </div>
                <% i++;%>
            
       <%}%>
           
           

                
</div>
        <div class="centerMaker">
            <a href="/players/<%: BetterWebApp.BetterSession.Current.user.id %>/halloffame" class="button" style="text-align: center; width:80%;">View Your Hall Of Fame</a>
        </div>
        
 </div>
</div>


              
        
    </section>
</asp:Content>

