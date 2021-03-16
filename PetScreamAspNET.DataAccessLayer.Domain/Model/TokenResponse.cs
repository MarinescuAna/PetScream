using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.DataAccessLayer.Domain.Model
{
   public class TokenResponse
    {
        public string AccessToken { get; set; }
        public string AccessTokenExpiration { get; set; }
    }
}
