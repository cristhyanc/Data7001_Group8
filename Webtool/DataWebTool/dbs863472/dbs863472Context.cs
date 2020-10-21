using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace DataWebTool.dbs863472
{
    public partial class dbs863472Context : DbContext
    {
        public dbs863472Context()
        {
        }

        public dbs863472Context(DbContextOptions<dbs863472Context> options)
            : base(options)
        {
        }

        public virtual DbSet<Education> Education { get; set; }
        public virtual DbSet<Education2016> Education2016 { get; set; }
        public virtual DbSet<Education2017> Education2017 { get; set; }
        public virtual DbSet<Electoraldistricts> Electoraldistricts { get; set; }
        public virtual DbSet<ElectorateSafety> ElectorateSafety { get; set; }
        public virtual DbSet<Fullelectoraldata> Fullelectoraldata { get; set; }
        public virtual DbSet<Population> Population { get; set; }
        public virtual DbSet<Population2014> Population2014 { get; set; }
        public virtual DbSet<Population2015> Population2015 { get; set; }
        public virtual DbSet<Population2016> Population2016 { get; set; }
        public virtual DbSet<Population2017> Population2017 { get; set; }
        public virtual DbSet<Population2018> Population2018 { get; set; }
        public virtual DbSet<Projectscsv> Projectscsv { get; set; }
        public virtual DbSet<_2011BornoverseasCensus> _2011BornoverseasCensus { get; set; }
        public virtual DbSet<_2016BornoverseasCensus> _2016BornoverseasCensus { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Education>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("education");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.EmployeeJobsAccommodation).HasColumnName("EmployeeJobs _Accommodation");

                entity.Property(e => e.EmployeeJobsAdministrative).HasColumnName("EmployeeJobs _Administrative");

                entity.Property(e => e.EmployeeJobsArts).HasColumnName("EmployeeJobs _Arts");

                entity.Property(e => e.EmployeeJobsConstruction).HasColumnName("EmployeeJobs _Construction");

                entity.Property(e => e.EmployeeJobsEducation).HasColumnName("EmployeeJobs _Education");

                entity.Property(e => e.EmployeeJobsElectricityGasWater).HasColumnName("EmployeeJobs _ElectricityGasWater");

                entity.Property(e => e.EmployeeJobsFinance).HasColumnName("EmployeeJobs _Finance");

                entity.Property(e => e.EmployeeJobsHealth).HasColumnName("EmployeeJobs _Health");

                entity.Property(e => e.EmployeeJobsInformation).HasColumnName("EmployeeJobs _Information");

                entity.Property(e => e.EmployeeJobsManufacturing).HasColumnName("EmployeeJobs _Manufacturing");

                entity.Property(e => e.EmployeeJobsOtherServices).HasColumnName("EmployeeJobs _OtherServices");

                entity.Property(e => e.EmployeeJobsProfessionalScientific).HasColumnName("EmployeeJobs _ProfessionalScientific");

                entity.Property(e => e.EmployeeJobsPublicAdministration).HasColumnName("EmployeeJobs _PublicAdministration");

                entity.Property(e => e.EmployeeJobsRental).HasColumnName("EmployeeJobs _Rental");

                entity.Property(e => e.EmployeeJobsRetail).HasColumnName("EmployeeJobs _Retail");

                entity.Property(e => e.EmployeeJobsTotal).HasColumnName("EmployeeJobs _Total");

                entity.Property(e => e.EmployeeJobsTransport).HasColumnName("EmployeeJobs _Transport");

                entity.Property(e => e.EmployeeJobsWholesaleTrade).HasColumnName("EmployeeJobs _WholesaleTrade");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.NumberOfEmployeeJobsOtherServices).HasColumnName("Number of Employee Jobs Other services");

                entity.Property(e => e.NumberOfEmployeeJobsTotal).HasColumnName("Number of Employee Jobs Total");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Education2016>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("education_2016");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.EmployeeJobsAccommodation).HasColumnName("EmployeeJobs _Accommodation");

                entity.Property(e => e.EmployeeJobsAdministrative).HasColumnName("EmployeeJobs _Administrative");

                entity.Property(e => e.EmployeeJobsArts).HasColumnName("EmployeeJobs _Arts");

                entity.Property(e => e.EmployeeJobsConstruction).HasColumnName("EmployeeJobs _Construction");

                entity.Property(e => e.EmployeeJobsEducation).HasColumnName("EmployeeJobs _Education");

                entity.Property(e => e.EmployeeJobsElectricityGasWater).HasColumnName("EmployeeJobs _ElectricityGasWater");

                entity.Property(e => e.EmployeeJobsFinance).HasColumnName("EmployeeJobs _Finance");

                entity.Property(e => e.EmployeeJobsHealth).HasColumnName("EmployeeJobs _Health");

                entity.Property(e => e.EmployeeJobsInformation).HasColumnName("EmployeeJobs _Information");

                entity.Property(e => e.EmployeeJobsManufacturing).HasColumnName("EmployeeJobs _Manufacturing");

                entity.Property(e => e.EmployeeJobsOtherServices).HasColumnName("EmployeeJobs _OtherServices");

                entity.Property(e => e.EmployeeJobsProfessionalScientific).HasColumnName("EmployeeJobs _ProfessionalScientific");

                entity.Property(e => e.EmployeeJobsPublicAdministration).HasColumnName("EmployeeJobs _PublicAdministration");

                entity.Property(e => e.EmployeeJobsRental).HasColumnName("EmployeeJobs _Rental");

                entity.Property(e => e.EmployeeJobsRetail).HasColumnName("EmployeeJobs _Retail");

                entity.Property(e => e.EmployeeJobsTotal).HasColumnName("EmployeeJobs _Total");

                entity.Property(e => e.EmployeeJobsTransport).HasColumnName("EmployeeJobs _Transport");

                entity.Property(e => e.EmployeeJobsWholesaleTrade).HasColumnName("EmployeeJobs _WholesaleTrade");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.NumberOfEmployeeJobsOtherServices).HasColumnName("Number of Employee Jobs Other services");

                entity.Property(e => e.NumberOfEmployeeJobsTotal).HasColumnName("Number of Employee Jobs Total");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Education2017>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("education_2017");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.EmployeeJobsAccommodation).HasColumnName("EmployeeJobs _Accommodation");

                entity.Property(e => e.EmployeeJobsAdministrative).HasColumnName("EmployeeJobs _Administrative");

                entity.Property(e => e.EmployeeJobsArts).HasColumnName("EmployeeJobs _Arts");

                entity.Property(e => e.EmployeeJobsConstruction).HasColumnName("EmployeeJobs _Construction");

                entity.Property(e => e.EmployeeJobsEducation).HasColumnName("EmployeeJobs _Education");

                entity.Property(e => e.EmployeeJobsElectricityGasWater).HasColumnName("EmployeeJobs _ElectricityGasWater");

                entity.Property(e => e.EmployeeJobsFinance).HasColumnName("EmployeeJobs _Finance");

                entity.Property(e => e.EmployeeJobsHealth).HasColumnName("EmployeeJobs _Health");

                entity.Property(e => e.EmployeeJobsInformation).HasColumnName("EmployeeJobs _Information");

                entity.Property(e => e.EmployeeJobsManufacturing).HasColumnName("EmployeeJobs _Manufacturing");

                entity.Property(e => e.EmployeeJobsOtherServices).HasColumnName("EmployeeJobs _OtherServices");

                entity.Property(e => e.EmployeeJobsProfessionalScientific).HasColumnName("EmployeeJobs _ProfessionalScientific");

                entity.Property(e => e.EmployeeJobsPublicAdministration).HasColumnName("EmployeeJobs _PublicAdministration");

                entity.Property(e => e.EmployeeJobsRental).HasColumnName("EmployeeJobs _Rental");

                entity.Property(e => e.EmployeeJobsRetail).HasColumnName("EmployeeJobs _Retail");

                entity.Property(e => e.EmployeeJobsTotal).HasColumnName("EmployeeJobs _Total");

                entity.Property(e => e.EmployeeJobsTransport).HasColumnName("EmployeeJobs _Transport");

                entity.Property(e => e.EmployeeJobsWholesaleTrade).HasColumnName("EmployeeJobs _WholesaleTrade");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.NumberOfEmployeeJobsOtherServices).HasColumnName("Number of Employee Jobs Other services");

                entity.Property(e => e.NumberOfEmployeeJobsTotal).HasColumnName("Number of Employee Jobs Total");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Electoraldistricts>(entity =>
            {
                entity.HasKey(e => e.IdelectoralDistrict)
                    .HasName("PRIMARY");

                entity.ToTable("electoraldistricts");

                entity.Property(e => e.IdelectoralDistrict).HasColumnName("idelectoralDistrict");

                entity.Property(e => e.ElectoralDistrict)
                    .IsRequired()
                    .HasColumnName("electoralDistrict")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<ElectorateSafety>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("electorate_safety");

                entity.Property(e => e.Electorate)
                    .HasMaxLength(16)
                    .IsUnicode(false);

                entity.Property(e => e.Margin).HasColumnType("decimal(4,2)");

                entity.Property(e => e.Party)
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.Safety)
                    .HasMaxLength(11)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Fullelectoraldata>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("fullelectoraldata");

                entity.Property(e => e.ElectoralDistrict)
                    .HasColumnName("electoralDistrict")
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.IdelectoralDistrict).HasColumnName("idelectoralDistrict");

                entity.Property(e => e.NumberVotes).HasColumnName("numberVotes");

                entity.Property(e => e.Party)
                    .HasColumnName("party")
                    .HasMaxLength(45)
                    .IsUnicode(false);

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Population>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("population");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.FemalesTotal).HasColumnName("femalesTotal");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MalesTotal).HasColumnName("malesTotal");

                entity.Property(e => e.MedianAgeFemales).HasColumnName("medianAgeFemales");

                entity.Property(e => e.MedianAgeMales).HasColumnName("medianAgeMales");

                entity.Property(e => e.MedianAgePersons).HasColumnName("medianAgePersons");

                entity.Property(e => e.PersonsTotal).HasColumnName("personsTotal");

                entity.Property(e => e.PopulationDensityPersonsKm2).HasColumnName("populationDensity(persons/km2)");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Population2014>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("population_2014");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.FemalesTotal).HasColumnName("femalesTotal");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MalesTotal).HasColumnName("malesTotal");

                entity.Property(e => e.MedianAgeFemales).HasColumnName("medianAgeFemales");

                entity.Property(e => e.MedianAgeMales).HasColumnName("medianAgeMales");

                entity.Property(e => e.MedianAgePersons).HasColumnName("medianAgePersons");

                entity.Property(e => e.PersonsTotal).HasColumnName("personsTotal");

                entity.Property(e => e.PopulationDensityPersonsKm2).HasColumnName("populationDensity(persons/km2)");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Population2015>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("population_2015");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.FemalesTotal).HasColumnName("femalesTotal");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.MalesTotal).HasColumnName("malesTotal");

                entity.Property(e => e.MedianAgeFemales).HasColumnName("medianAgeFemales");

                entity.Property(e => e.MedianAgeMales).HasColumnName("medianAgeMales");

                entity.Property(e => e.MedianAgePersons).HasColumnName("medianAgePersons");

                entity.Property(e => e.PersonsTotal).HasColumnName("personsTotal");

                entity.Property(e => e.PopulationDensityPersonsKm2).HasColumnName("populationDensity(persons/km2)");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Population2016>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("population_2016");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.FemalesTotal).HasColumnName("femalesTotal");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.MalesTotal).HasColumnName("malesTotal");

                entity.Property(e => e.MedianAgeFemales).HasColumnName("medianAgeFemales");

                entity.Property(e => e.MedianAgeMales).HasColumnName("medianAgeMales");

                entity.Property(e => e.MedianAgesPersons).HasColumnName("medianAgesPersons");

                entity.Property(e => e.PersonsTotal).HasColumnName("personsTotal");

                entity.Property(e => e.PopulationDensityPersonsKm2).HasColumnName("populationDensity(persons/km2)");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Population2017>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("population_2017");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.FemalesTotal).HasColumnName("femalesTotal");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.MalesTotal).HasColumnName("malesTotal");

                entity.Property(e => e.MedianAgeFemales).HasColumnName("medianAgeFemales");

                entity.Property(e => e.MedianAgeMales).HasColumnName("medianAgeMales");

                entity.Property(e => e.MedianAgePersons).HasColumnName("medianAgePersons");

                entity.Property(e => e.PersonsTotal).HasColumnName("personsTotal");

                entity.Property(e => e.PopulationDensityPersonsKm2).HasColumnName("populationDensity(persons/km2)");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Population2018>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("population_2018");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.FemalesTotal).HasColumnName("femalesTotal");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.MalesTotal).HasColumnName("malesTotal");

                entity.Property(e => e.MedianAgeFemales).HasColumnName("medianAgeFemales");

                entity.Property(e => e.MedianAgeMales).HasColumnName("medianAgeMales");

                entity.Property(e => e.MedianAgePersons).HasColumnName("medianAgePersons");

                entity.Property(e => e.PersonsTotal).HasColumnName("personsTotal");

                entity.Property(e => e.PopulationDensityPersonsKm2).HasColumnName("populationDensity(persons/km2)");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<Projectscsv>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("projectscsv");

                entity.Property(e => e.Annotations)
                    .HasMaxLength(113)
                    .IsUnicode(false);

                entity.Property(e => e.Commentary)
                    .HasMaxLength(190)
                    .IsUnicode(false);

                entity.Property(e => e.CurrentFinancialYearExpenditure).HasColumnType("decimal(15,2)");

                entity.Property(e => e.Department)
                    .HasMaxLength(42)
                    .IsUnicode(false);

                entity.Property(e => e.Electorate)
                    .IsRequired()
                    .HasColumnName("electorate")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FinancialYear)
                    .HasMaxLength(11)
                    .IsUnicode(false);

                entity.Property(e => e.FutureFinancialYearExpenditure).HasColumnType("decimal(15,2)");

                entity.Property(e => e.GeneralDepartment)
                    .HasMaxLength(45)
                    .IsUnicode(false);

                entity.Property(e => e.IndicativePqcrating)
                    .HasColumnName("IndicativePQCRating")
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.IndigenousCommunity)
                    .HasMaxLength(3)
                    .IsUnicode(false);

                entity.Property(e => e.LastFinancialYearExpenditure).HasColumnType("decimal(15,2)");

                entity.Property(e => e.Latitude)
                    .HasColumnName("latitude")
                    .HasColumnType("decimal(10,7)");

                entity.Property(e => e.Longitude)
                    .HasColumnName("longitude")
                    .HasColumnType("decimal(10,7)");

                entity.Property(e => e.OngoingProgram)
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.ProcurementSystem)
                    .HasMaxLength(15)
                    .IsUnicode(false);

                entity.Property(e => e.ProjectEnvironment)
                    .HasMaxLength(36)
                    .IsUnicode(false);

                entity.Property(e => e.ProjectNumber)
                    .HasMaxLength(31)
                    .IsUnicode(false);

                entity.Property(e => e.ProjectTitle)
                    .HasMaxLength(249)
                    .IsUnicode(false);

                entity.Property(e => e.ProjectType)
                    .HasMaxLength(25)
                    .IsUnicode(false);

                entity.Property(e => e.Region)
                    .HasMaxLength(28)
                    .IsUnicode(false);

                entity.Property(e => e.TenderCall)
                    .HasMaxLength(27)
                    .IsUnicode(false);

                entity.Property(e => e.TenderType)
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.Property(e => e.TotalEstimatedCost).HasColumnType("decimal(15,2)");
            });

            modelBuilder.Entity<_2011BornoverseasCensus>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("2011_bornoverseas_census");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.Females).HasColumnName("females");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.Males).HasColumnName("males");

                entity.Property(e => e.Persons).HasColumnName("persons");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            modelBuilder.Entity<_2016BornoverseasCensus>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PRIMARY");

                entity.ToTable("2016_bornoverseas_census");

                entity.Property(e => e.Code).HasColumnName("code");

                entity.Property(e => e.Females).HasColumnName("females");

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasColumnName("label");

                entity.Property(e => e.Males).HasColumnName("males");

                entity.Property(e => e.Persons).HasColumnName("persons");

                entity.Property(e => e.Year).HasColumnName("year");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
