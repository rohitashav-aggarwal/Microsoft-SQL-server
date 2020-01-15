using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProductInventory
{
    public partial class frmProducts : Form
    {
        // form-level variables
        List<Product> products = new List<Product>(); // empty list

        public frmProducts()
        {
            InitializeComponent();
        }

        // exit the program
        private void btnExit_Click(object sender, EventArgs e)
        {
            Close(); // close the form and terminate
        }

        // prepare for next entry
        private void btnClear_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtPrice.Text = "";
            txtQuantity.Text = "";
            txtName.Focus();
        }

        // add another product to the list
        private void btnAdd_Click(object sender, EventArgs e)
        {
            string name;
            decimal price;
            int qty;
            if (Validator.IsPresent(txtName, "Name") &&
                Validator.IsPresent(txtPrice, "Price") &&
                Validator.IsNonNegativeDecimal(txtPrice, "Price") &&
                Validator.IsPresent(txtQuantity, "Quantity") &&
                Validator.IsNonNegativeInt32(txtQuantity, "Quantity")
                )
            {
                // get data from text boxes
                name = txtName.Text;
                price = Convert.ToDecimal(txtPrice.Text);
                qty = Convert.ToInt32(txtQuantity.Text);
                // create a product object
                Product p = new Product(name, price, qty);
                // add it to the list
                products.Add(p);
                DisplayProducts();
            }
        }

        private void DisplayProducts()
        {
            lstProducts.Items.Clear();
            foreach (Product p in products)
                lstProducts.Items.Add(p); // implicitly calls ToString()
            lblCount.Text = products.Count.ToString();
            lblInventory.Text = CalculateInventory().ToString("c");
        }

        // save the data just before the form closes
        private void frmProducts_FormClosing(object sender, FormClosingEventArgs e)
        {
            ProductDB.SaveProducts(products);
        }

        // read product from the file and display
        private void frmProducts_Load(object sender, EventArgs e)
        {
            products = ProductDB.ReadProducts();
            DisplayProducts();
        }

        // total inventory value of all products
        private decimal CalculateInventory()
        {
            decimal total = 0;
            foreach (Product p in products)
                total += p.InventoryValue();
            return total;
        }

        // buy selected product
        private void btnBuy_Click(object sender, EventArgs e)
        {
            int index = lstProducts.SelectedIndex;
            int qtyToBuy;
            if(index == -1)
            {
                MessageBox.Show("You need to select product first");
                return;
            }
            if(Validator.IsPresent(txtBuySellQty, "Quantity to buy") &&
               Validator.IsNonNegativeInt32(txtBuySellQty, "Quantity to buy"))
            {
                qtyToBuy = Convert.ToInt32(txtBuySellQty.Text);
                products[index].Qty += qtyToBuy;
                DisplayProducts();
            }
        }

        private void btnSell_Click(object sender, EventArgs e)
        {
            int index = lstProducts.SelectedIndex;
            int qtyToSell;
            if (index == -1)
            {
                MessageBox.Show("You need to select product first");
                return;
            }
            if (Validator.IsPresent(txtBuySellQty, "Quantity to sell") &&
               Validator.IsNonNegativeInt32(txtBuySellQty, "Quantity to sell"))
            {
                qtyToSell = Convert.ToInt32(txtBuySellQty.Text);
                if (qtyToSell > products[index].Qty) // not enough
                    MessageBox.Show("We only have " + products[index].Qty +
                        " of " + products[index].Name + "(s)"+
                        "\nTry again");
                else
                {
                    products[index].Qty -= qtyToSell;
                    DisplayProducts();
                }
            }
        }
    } // end form class
}// end namespace
