﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using PetScreamAspNET.DataAccessLayer.Repository;

namespace PetScreamAspNET.DataAccessLayer.Repository.Migrations
{
    [DbContext(typeof(PetScreamDbContext))]
    partial class PetSscreamDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.1.14-servicing-32113")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("PetScreamAspNET.DataAccessLayer.Domain.Domain.Image", b =>
                {
                    b.Property<Guid>("ImageID")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Content");

                    b.Property<string>("Extention");

                    b.Property<string>("Filename");

                    b.HasKey("ImageID");

                    b.ToTable("Images");
                });

            modelBuilder.Entity("PetScreamAspNET.DataAccessLayer.Domain.Domain.Post", b =>
                {
                    b.Property<Guid>("PostID")
                        .ValueGeneratedOnAdd();

                    b.Property<DateTime>("FoundDatetime");

                    b.Property<string>("FounderAddress");

                    b.Property<string>("FounderName");

                    b.Property<string>("FounderPhone");

                    b.Property<Guid>("ImageId");

                    b.Property<DateTime>("LostDatetime");

                    b.Property<string>("LostPlaceAddress");

                    b.Property<string>("OwnerAddress");

                    b.Property<string>("PetDescription");

                    b.Property<DateTime>("PostDatetime");

                    b.Property<int>("Status");

                    b.Property<string>("Title");

                    b.Property<string>("UserId");

                    b.HasKey("PostID");

                    b.HasIndex("ImageId");

                    b.HasIndex("UserId");

                    b.ToTable("Posts");
                });

            modelBuilder.Entity("PetScreamAspNET.DataAccessLayer.Domain.Domain.User", b =>
                {
                    b.Property<string>("Email")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("AccessToken");

                    b.Property<DateTime?>("AccessTokenExp");

                    b.Property<string>("Name");

                    b.Property<string>("Password");

                    b.Property<string>("Phone");

                    b.HasKey("Email");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("PetScreamAspNET.DataAccessLayer.Domain.Domain.Post", b =>
                {
                    b.HasOne("PetScreamAspNET.DataAccessLayer.Domain.Domain.Image", "Image")
                        .WithMany("Posts")
                        .HasForeignKey("ImageId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("PetScreamAspNET.DataAccessLayer.Domain.Domain.User", "Owner")
                        .WithMany("Posts")
                        .HasForeignKey("UserId");
                });
#pragma warning restore 612, 618
        }
    }
}
