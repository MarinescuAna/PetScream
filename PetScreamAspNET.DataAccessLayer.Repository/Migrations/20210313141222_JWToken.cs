using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace PetScreamAspNET.DataAccessLayer.Repository.Migrations
{
    public partial class JWToken : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "AccessToken",
                table: "Users",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "AccessTokenExp",
                table: "Users",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AccessToken",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "AccessTokenExp",
                table: "Users");
        }
    }
}
