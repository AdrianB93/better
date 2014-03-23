using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class FixedCharacter
    {
        private int sId;
        public int id
        {
            get
            {
                return sId;
            }
            set
            {
                sId = value;
            }
        }
        private int sElementID;
        public int elementID
        {
            get
            {
                return sElementID;
            }
            set
            {
                sElementID = value;
            }
        }
        private String sName;
        public String name
        {
            get
            {
                return sName;
            }
            set
            {
                sName = value;
            }
        }
        private string sDescription;
        public String description
        {
            get
            {
                return sDescription;
            }
            set
            {
                sDescription = value;
            }
        }
        private string sImageFileName;
        public String imageFileName
        {
            get
            {
                return sImageFileName;
            }
            set
            {
                sImageFileName = value;
            }
        }
        
        private double sDamagePointsOverride;
        public double damagePointsOverride
        {
            get
            {
                if (this.sDamagePointsOverride == -1.0) return this.element.damagePoints; // No overidden, get default value
                else return sDamagePointsOverride;
            }
            set { this.sDamagePointsOverride = value; }
        }
        private double sDefencePointsOverride;
        public double defencePointsOverride
        {
            get
            {
                if (this.sDefencePointsOverride == -1.0) return this.element.defencePoints; // No overidden, get default value
                else return sDefencePointsOverride;
            }
            set { this.sDefencePointsOverride = value; }
        }
        private double sDamageVariationOverride;
        public double damageVariationOverride
        {
            get
            {
                if (this.sDamageVariationOverride == -1.0) return this.element.damageVariation; // No overidden, get default value
                else return sDamageVariationOverride;
            }
            set { this.sDamageVariationOverride = value; }
        }
        private double sDefenceVariationOverride;
        public double defenceVariationOverride
        {
            get
            {
                if (this.sDefenceVariationOverride == -1.0) return this.element.defenceVariation; // No overidden, get default value
                else return sDefenceVariationOverride;
            }
            set { this.sDefenceVariationOverride = value; }
        }
        private int sXpPerLevelOverride;
        public int xpPerLevelOverride
        {
            get
            {
                if (this.sXpPerLevelOverride == -1) return this.element.xpPerLevel; // No overidden, get default value
                else return sXpPerLevelOverride;
            }
            set { this.sXpPerLevelOverride = value; }
        }

        public FixedCharacter(int id, int elementID, String name, String description, String imageFileName, double damagePointsOverride, double defencePointsOverride, double damageVariationOverride, double defenceVariationOverride, int xpPerLevelOverride)
        {
            this.id = id;
            this.elementID = elementID;
            this.name = name;
            this.description = description;
            this.imageFileName = imageFileName;
            this.damagePointsOverride = damagePointsOverride;
            this.defencePointsOverride = defencePointsOverride;
            this.damageVariationOverride = damageVariationOverride;
            this.defenceVariationOverride = defenceVariationOverride;
            this.xpPerLevelOverride = xpPerLevelOverride;
        }

        public Element element
        {
            get { return Utilities.elements[elementID - 1]; } // Get the Element object of this FixedCharacter
        }
    }
}