using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.DataAccessLayer.Domain.Model
{
    public class InsertPostSender
    {
        public string Title { get; set; }
        public string PetDescription { get; set; }
        public string OwnerAddress { get; set; }
        public string LostPlaceAddress { get; set; }
        public string LostDatetime { get; set; }
       public string BinaryContentImage { get; set; }
        public string ImageName { get; set; }
        public string ExtentionImage { get; set; }

    }
}
