using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class Element
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
        private String sDescription;
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
        private int sOppositeId;
        public int oppositeId
        {
            get
            {
                return sOppositeId;
            }
            set
            {
                sOppositeId = value;
            }
        }
        private double sDamagePoints;
        public double damagePoints
        {
            get
            {
                return sDamagePoints;
            }
            set
            {
                sDamagePoints = value;
            }
        }
        private double sDefencePoints;
        public double defencePoints
        {
            get
            {
                return sDefencePoints;
            }
            set
            {
                sDefencePoints = value;
            }
        }
        private double sDamageVariation;
        public double damageVariation
        {
            get
            {
                return sDamageVariation;
            }
            set
            {
                sDamageVariation = value;
            }
        }
        private double sDefenceVariation;
        public double defenceVariation
        {
            get
            {
                return sDefenceVariation;
            }
            set
            {
                sDefenceVariation = value;
            }
        }
        private int sXpPerLevel;
        public int xpPerLevel
        {
            get
            {
                return sXpPerLevel;
            }
            set
            {
                sXpPerLevel = value;
            }
        }

        public Element(int id, String name, String description, int oppositeId, double damagePoints, double defencePoints, double damageVariation, double defenceVariation, int xpPerLevel)
        {
            this.id = id;
            this.name = name;
            this.description = description;
            this.oppositeId = oppositeId;
            this.damagePoints = damagePoints;
            this.defencePoints = defencePoints;
            this.damageVariation = damageVariation;
            this.defenceVariation = defenceVariation;
            this.xpPerLevel = xpPerLevel;
        }
    }
}