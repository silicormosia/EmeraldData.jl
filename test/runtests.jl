using EmeraldData
using EmeraldData.Blender
using EmeraldData.Collector
using EmeraldData.Fetcher
using EmeraldData.Indexer
using EmeraldData.Requestor
using Test


@testset verbose = true "EmeraldData" begin
    @testset "Database" begin
        # the update functions
        EmeraldData.update_database!(); @test true;

        # the judge functions
        EmeraldData.artifact_exists("CH_2X_1Y_V2"); @test true;
        EmeraldData.artifact_exists("031f34db3ce1921a723d8e4151ee6c6fe5566714"); @test true;
        EmeraldData.artifact_downloaded("CH_2X_1Y_V2"); @test true;

        # the index functions
        EmeraldData.artifact_file("CH_2X_1Y_V2"); @test true;
        EmeraldData.artifact_folder("CH_2X_1Y_V2"); @test true;
        EmeraldData.artifact_sha("CH_2X_1Y_V2"); @test true;
        EmeraldData.artifact_tags(); @test true;
        EmeraldData.cache_folder(); @test true;
        EmeraldData.public_folder(); @test true;
        EmeraldData.tarball_folder(); @test true;
        EmeraldData.tarball_folder("CH_2X_1Y_V2"); @test true;
        EmeraldData.tarball_file("CH_2X_1Y_V2"); @test true;
    end;

    @testset "Collector" begin
        # test download_artifact! function
        Collector.download_artifact!("CH_2X_1Y_V2"); @test true;
        Collector.download_artifact!("PFT_2X_1Y_V1"); @test true;

        # clean up artifacts
        Collector.clean_database!("old"); @test true;
    end;

    @testset "Indexer" begin
        Indexer.read_LUT("CI_2X_1Y_V1"); @test true;
        Indexer.read_LUT("CI_2X_1M_V3"); @test true;
        Indexer.read_LUT("CI_2X_1M_V3", 8); @test true;
        Indexer.read_LUT("CI_2X_1M_V3", 30, 116); @test true;
        Indexer.read_LUT("CI_2X_1M_V3", 30, 116; interpolation = true); @test true;
        Indexer.read_LUT("CI_2X_1M_V3", 30, 116, 8); @test true;
        Indexer.read_LUT("REFLECTANCE_MCD43A4_B1_1X_1M_2000_V1", 30, 116, 8); @test true;
    end;

    @testset "Blender" begin
        Blender.regrid(rand(720,360), 1); @test true;
        Blender.regrid(rand(720,360,2), 1); @test true;
        Blender.regrid(rand(360,180), 2); @test true;
        Blender.regrid(rand(360,180,2), 2); @test true;
        Blender.regrid(rand(360,180), (144,96)); @test true;
        Blender.regrid(rand(360,180,2), (144,96)); @test true;
    end;

    @testset "Requestor" begin
        Requestor.request_site_data("LAI_MODIS_2X_8D_2017_V1", 30.5, 115.5); @test true;
        Requestor.request_site_data("LAI_MODIS_2X_8D_2017_V1", 30.5, 115.5; interpolation=true); @test true;
        Requestor.request_site_data("LAI_MODIS_2X_8D_2017_V1", 30.5, 115.5, 8); @test true;
        Requestor.request_site_data("LAI_MODIS_2X_8D_2017_V1", 30.5, 115.5, 8; interpolation=true); @test true;
    end;

    #=
    @testset "Partitioner" begin
        if Sys.islinux() && (Sys.total_memory() / 2^30) > 64
            folder = "/net/fluo/data2/pool/database/EmeraldData/test/partitioner_tests/"
            Partitioner.partition_from_json(folder * "partition_test_random.json"); @test true;
            Partitioner.clean_files(folder * "partition_test_random.json", 2023; months = [1]); @test true;
            Partitioner.partition_from_json(folder * "partition_test_oco2.json"); @test true;
            Partitioner.get_data_from_json(folder * "partition_test_oco2.json", [-50.1 -19.8; 70.2 -18.2; 60.3 12.2; -40.7 11.4], 2022); @test true;
            Partitioner.clean_files(folder * "partition_test_oco2.json", 2022; months = [1]); @test true;
            rm(folder * "partitioned_files"; recursive = true); @test true;
        end;
    end;
    =#
end;
