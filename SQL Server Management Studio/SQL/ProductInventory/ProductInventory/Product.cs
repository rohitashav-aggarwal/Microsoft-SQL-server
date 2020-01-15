using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProductInventory
{
    public class Product
    {
        // private data
        //private string name; // do not declare private 
                                //for auto-implemented property
        private decimal price;
        private int qty;

        // public properties
        public string Name { get; set; }// auto-implemented propery
        // creates a private (unnamed) variable behind the property
       
        public decimal Price
        {
            get{ return price; }
            set
            {
                // if provided value is negative, make it zero
                price = (value < 0) ? -value : value;
            }
        }
        public int Qty
        {
            get { return qty; }
            set
            {
                // if provided value is negative, make it zero
                qty = (value < 0) ? -value : value;
            }
        }


        // constructors
        // if you do not provide a constructor, compiler supplies default 
        //  constructor (no parameters)
        public Product() { } // default constructor
        public Product(string n, decimal p, int q) // constructor with params
        {
            Name = n;
            Price = p;
            Qty = q;    
        }

        // public operations

        public decimal InventoryValue()
        {
            return price * qty;
        }

        public override string ToString() // for display
        {
            return Name + ": " + price.ToString("c") + ", " + qty.ToString();
        }

        public string ToCSV()// for writing CSV file - no formatting
        {
            return Name + "," + price.ToString() + "," + qty.ToString();
        }

    } // end class
} // end namespace
