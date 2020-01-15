using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProductInventory
{
    public static class ProductDB
    {
        const string path = "products.txt"; // located in bin/Debug folder

        public static List<Product> ReadProducts()
        {
            List<Product> prodList = new List<Product>(); // create empty list
            Product p; // for reading products
            string line; // next line from the file
            string[] fields; // line broken into fields
            using(FileStream fs = new FileStream(path,FileMode.OpenOrCreate,
                                                 FileAccess.Read))
            {
                using(StreamReader sr = new StreamReader(fs))
                {
                    while(!sr.EndOfStream)// while there is still unread data
                    {
                        line = sr.ReadLine();
                        fields = line.Split(',');// split where the commas are
                        p = new Product(); // create product and fill with data
                        p.Name = fields[0];
                        p.Price = Convert.ToDecimal(fields[1]);
                        p.Qty = Convert.ToInt32(fields[2]);
                        prodList.Add(p); // add it to the list
                    }
                } // closes sr and recycles
            } // closes fs and recycles
            return prodList;
        }

        public static void SaveProducts(List<Product> productList)
        {
            using(FileStream fs = new FileStream(path, FileMode.Create,
                                                FileAccess.Write))
            {
                using(StreamWriter sw = new StreamWriter(fs))
                {
                    foreach(Product p in productList)
                    {
                        sw.WriteLine(p.ToCSV());
                    }
                } // closes the sw and recyles
            }// closes the fs and recycles
        }
    }
}
