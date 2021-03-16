using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.DataAccessLayer.Domain.Model
{
    public class UserRegisterModel
    {
        public string Email { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string Phone { get; set; }
    }
}
