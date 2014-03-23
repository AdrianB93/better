<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Help - B.E.T.T.E.R.
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Help</h1>

    <article>
		<h2>
			How do I register?
		</h2>
		<p>
            Registration is easy! Just head to our Register page, fill in your email address and username, pick a password (be sure to type it in both password boxes so you know it's right) and click Register! Be sure to get a parent's permission before registering though!
        </p>
		<h2>
			How do I battle another monster?
		</h2> // Please take a look at this to make sure I have this done right.
		<p>
			To battle another monster, go to a friend's profile, select a monster to battle and Click Battle. You will then have to choose your monster you want to use to battle. Once you have clicked on your monster, click "Battle Now". You will then begin the battle!
		</p>
		<h2>Why can't I create more than four monsters?</h2>
		<p>
			You can only have one monster for each element. More elements may be added later, so once they are, you can have another monster for that element.
		</p>
		<h2>What is the Hall of Fame?</h2>
		<p>
			When your monster goes past Level 4, it will enter into the Hall of Fame. The Hall of Fame is for all monsters that have levelled up high enough to be totally awesome! Once a monster enters the Hall of Fame, you will no longer be able to use that monster, but fret not! You can now create a new monster with the same element of that monster!
		</p>
		<h2>I have another question that isn't answered here, where can I get an answer?</h2>
		<p>
			You can visit our Contact page and send us a message there.
		</p>
    </article>

</asp:Content>