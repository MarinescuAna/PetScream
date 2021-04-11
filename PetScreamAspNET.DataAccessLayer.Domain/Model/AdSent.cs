using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.DataAccessLayer.Domain.Model
{
    public class AdSent
    {
        public string PostID { get; set; }
        public string Title { get; set; }
        public string PetDescription { get; set; }
        public string OwnerAddress { get; set; }
        public string FounderAddress { get; set; }
        public string LostPlaceAddress { get; set; }
        public string FounderName { get; set; }
        public string FounderPhone { get; set; }
        public DateTime LostDatetime { get; set; }
        public DateTime PostDatetime { get; set; }
        public DateTime FoundDatetime { get; set; }
        public string Status { get; set; }
        public string UserEmail { get; set; }
        public string ContentImage { get; set; }
        public string Name { get; set; }
        public string Phone { get; set; }
    }
}
