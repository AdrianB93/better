<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create a Character!
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/characters" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>

<h1>Create Character</h1>
    <div class="chardivContainer">
        <fieldset class="registerForm">
            <legend>Create Character</legend>
            <form action="/characters" method="post">

                <div class="characterSegment">
                    <label for="monsterName">Monster Name:</label>
                    <input type="text" name ="monsterName" placeholder="Choose a name!" value="<%: ViewBag.monsterName %>" />
                </div>
                
                <div class="characterSegment">
                    <label for="monsterImage">Upload image:</label>
                    <input type="file" name="fileupload" accept="image/*" />
                </div>

                <div class="elementHolder characterSegment">
                    <div class="singleElement">
                        <img src="/images/characters/water/00000001.png" class="elementImage" />
                        <br />
                        <label for="monsterImage">Water</label>
                        <br />
                        <p class="centerMaker statTextHead">Stats:</p>
                        <p class="statText">Opposite: <span class="textboxAlign2">Fire</span></p>
                        <p class="statText">Damage Points: <span class="textboxAlign2">4.0</span></p>
                        <p class="statText">Defence Points: <span class="textboxAlign2">7.0</span></p>
                        <p class="statText">Damage Variation: <span class="textboxAlign2">5.0</span></p>
                        <p class="statText">Defence Variation: <span class="textboxAlign2">10.0</span></p>
                        <br />
                        <div class="bottomElement">
                            <input type="radio" name="element" value="1"  class="elementRadio"  checked/>
                        </div>
                    </div>

                    <div class="singleElement">
                        <img src="/images/characters/earth/00000001.png" class="elementImage" />
                        <br />
                        <label for="monsterImage">Earth</label>
                        <br />
                        <p class="centerMaker statTextHead">Stats:</p>
                        <p class="statText">Opposite: <span class="textboxAlign2">Air</span></p>
                        <p class="statText">Damage Points: <span class="textboxAlign2">8.0</span></p>
                        <p class="statText">Defence Points: <span class="textboxAlign2">4.0</span></p>
                        <p class="statText">Damage Variation: <span class="textboxAlign2">15.0</span></p>
                        <p class="statText">Defence Variation: <span class="textboxAlign2">10.0</span></p>
                        <br />
                        <div class="bottomElement">
                            <input type="radio" name="element" value="2" class="elementRadio" />
                        </div>
                    </div>

                    <div class="singleElement">
                        <img src="/images/characters/fire/00000001.png" class="elementImage" />
                        <br />
                        <label for="monsterImage">Fire</label>
                        
                        <p class="centerMaker statTextHead">Stats:</p>
                        <p class="statText">Opposite: <span class="textboxAlign2">Water</span></p>
                        <p class="statText">Damage Points: <span class="textboxAlign2">6.0</span></p>
                        <p class="statText">Defence Points: <span class="textboxAlign2">3.0</span></p>
                        <p class="statText">Damage Variation: <span class="textboxAlign2">15.0</span></p>
                        <p class="statText">Defence Variation: <span class="textboxAlign2">2.0</span></p>
                        <br />
                        <div class="bottomElement">
                            <input type="radio" name="element" value="3"  class="elementRadio" />
                        </div>
                    </div>

                    <div class="singleElement">
                        <img src="/images/characters/air/00000001.png" class="elementImage" />
                        <br />
                        <label for="monsterImage">Air</label>
                        <p class="centerMaker statTextHead">Stats:</p>
                        <p class="statText">Opposite: <span class="textboxAlign2">Earth</span></p>
                        <p class="statText">Damage Points: <span class="textboxAlign2">3.0</span></p>
                        <p class="statText">Defence Points: <span class="textboxAlign2">10.0</span></p>
                        <p class="statText">Damage Variation: <span class="textboxAlign2">20.0</span></p>
                        <p class="statText">Defence Variation: <span class="textboxAlign2">0.0</span></p>
                        <br />
                        <div class="bottomElement">
                            <input type="radio" name="element" value="4" class="elementRadio" />
                        </div>
                    </div>
                </div>

                <div class="centerMaker">
                    <input type="submit" value="Create!" class="createButton"/>
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
