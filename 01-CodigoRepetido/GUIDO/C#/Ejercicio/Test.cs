using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IdiomExercise
{
    [TestClass]
    public class Test
    {
        [TestMethod]
        public void AddingCustomerShouldNotTakeMoreThan50Milliseconds()
        {
            DateTime tiempoFinal = tiempoParaAgregandoOQuitando(1);
           /* CustomerBook customerBook = new CustomerBook();

            DateTime timeBeforeRunning = DateTime.Now;
            customerBook.addCustomerNamed("John Lennon");
            DateTime timeAfterRunning = DateTime.Now;
*/
            Assert.IsTrue(tiempoFinal < 50);
        }

        [TestMethod]
        public void RemovingCustomerShouldNotTakeMoreThan100Milliseconds()
        {
            DateTime tiempoFinal = tiempoParaAgregandoOQuitando(0);
           /* CustomerBook customerBook = new CustomerBook();
            String paulMcCartney = "Paul McCartney";

            customerBook.addCustomerNamed(paulMcCartney);

            DateTime timeBeforeRunning = DateTime.Now;
            customerBook.removeCustomerNamed(paulMcCartney);
            DateTime timeAfterRunning = DateTime.Now;
*/
            Assert.IsTrue(tiempoFinal < 100);
        }

        [TestMethod]
        public void CanNotAddACustomerWithEmptyName()
        {

            /*
            CustomerBook customerBook = new CustomerBook();

            try
            {
                customerBook.addCustomerNamed("");
                Assert.Fail();
            }
            catch (Exception e)
            {
                Assert.AreEqual(e.Message, CustomerBook.CUSTOMER_NAME_EMPTY);
                Assert.IsTrue(customerBook.isEmpty());
            }*/
            canNotRemOAdd(1);
        }

        [TestMethod]
        public void CanNotRemoveNotAddedCustomer()
        {
            /*CustomerBook customerBook = new CustomerBook();
            
            try
            {
                customerBook.removeCustomerNamed("John Lennon");
                Assert.Fail();
            }
            // Se utiliza otro tipo de exception por motivos del ejercicio
            catch (InvalidOperationException e)
            {
                Assert.AreEqual(e.Message, CustomerBook.INVALID_CUSTOMER_NAME);
                Assert.AreEqual(0, customerBook.numberOfCustomers());
            }*/
            canNotRemOAdd(0);

        }
        DateTime tiempoParaAgregandoOQuitando(int addOrRev){
            CustomerBook customerBook = new CustomerBook();
            if (addOrRev == 0){
                String paulMcCartney = "Paul McCartney";
                customerBook.addCustomerNamed(paulMcCartney);
            }
            DateTime timeBeforeRunning = DateTime.Now;
            if(addOrRev == 1){
                customerBook.addCustomerNamed("John Lennon");
            }else{
                customerBook.removeCustomerNamed(paulMcCartney);
            }
            DateTime timeAfterRunning = DateTime.Now;

            return timeAfterRunning.Subtract(timeBeforeRunning).TotalMilliseconds;

        }

        void canNotRemOAdd(int addOrRev){
            CustomerBook customerBook = new CustomerBook();
            try {
                 if(addOrRev == 1){
                    customerBook.addCustomerNamed("");
                 }else{
                    customerBook.removeCustomerNamed("John Lennon");
                 }
                    Assert.Fail();
            }
            if(addOrRev == 1){
                catch (Exception e) {
                    Assert.AreEqual(e.Message, CustomerBook.CUSTOMER_NAME_EMPTY);
                    Assert.IsTrue(customerBook.isEmpty());
                }
            }else{
                catch (InvalidOperationException e) {
                    Assert.AreEqual(e.Message, CustomerBook.INVALID_CUSTOMER_NAME);
                    Assert.AreEqual(0, customerBook.numberOfCustomers());
                 }
            }
    }


}
