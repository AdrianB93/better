<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Add Exercise
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

           <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/exercise" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>
<h1>Add Exercise</h1>
    
     <div class="exercisedivContainer">
        <fieldset class="registerForm">
            <legend>Add Exercise</legend>
            <form action="/exercise" method="post" >
                

        <div  class="registerForm-li">

            <label for="shakes" >Upload XML File:</label>
            <span class="textboxAlign">
                <input type="file" name="xmlupload" accept="text/xml" />
            </span>
        </div>
              
        <div  class="registerForm-li">
            <label for="pinCode">Parent Pin Number: (<%: BetterWebApp.BetterSession.Current.user.parentPIN %>)</label>
            <input type="password" name="pinCode" class="pinCode"/>
        </div>
                                                          

                <div class="centerMaker">
                    <input type="submit" value="Add Exercise" />
                </div>
            </form>
            
                
            </fieldset>
            </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <% if (ViewBag.error) { %>
    <h1>ERROR</h1>
    <p style="text-align: center;"><%: ViewBag.errorMsg %></p>
    <% } %>
</asp:Content>
