using Microsoft.EntityFrameworkCore;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using System;

namespace PetScreamAspNET.DataAccessLayer.Repository
{
    public class PetSscreamDbContext: DbContext
    {
        public PetSscreamDbContext(DbContextOptions<PetSscreamDbContext> context) : base(context)
        {

        }

        public DbSet<User> Users { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<Image> Images { get; set; }

    }
}
