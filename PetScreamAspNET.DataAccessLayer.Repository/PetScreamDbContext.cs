using Microsoft.EntityFrameworkCore;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using System;

namespace PetScreamAspNET.DataAccessLayer.Repository
{
    public class PetScreamDbContext: DbContext
    {
        public PetScreamDbContext(DbContextOptions<PetScreamDbContext> context) : base(context)
        {

        }

        public DbSet<User> Users { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<Image> Images { get; set; }

    }
}
