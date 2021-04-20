using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.DataAccessLayer.Domain.Domain
{
    public  enum Status
    {
        Found,
        Lost
    }
    public class Post
    {
        public Guid PostID { get; set; }
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
        public Status Status { get; set; }
        public string UserId { get; set; }
        public Guid ImageId { get; set; }

        public virtual User Owner { get; set; }
        public virtual Image Image { get; set; }
        
    }
}
