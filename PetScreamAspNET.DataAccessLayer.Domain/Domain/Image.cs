using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.DataAccessLayer.Domain.Domain
{
    public class Image
    {
        public Guid ImageID { get; set; }
        public string Content { get; set; }
        public string Extention { get; set; }
        public string Filename { get; set; }
        public ICollection<Post> Posts { get; set; }

    }
}
