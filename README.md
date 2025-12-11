# EmeraldData.jl

<!-- Links and shortcuts -->
[ed-url]: https://github.com/silicormosia/EmeraldData.jl
[ed-api]: https://silicormosia.github.io/EmeraldData.jl/stable/API/

[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://silicormosia.github.io/EmeraldData.jl/dev/

[st-img]: https://github.com/silicormosia/EmeraldData.jl/workflows/JuliaStable/badge.svg?branch=main
[st-url]: https://github.com/silicormosia/EmeraldData.jl/actions?query=branch%3A"main"++workflow%3A"JuliaStable"

[cov-img]: https://codecov.io/gh/silicormosia/EmeraldData.jl/branch/main/graph/badge.svg
[cov-url]: https://codecov.io/gh/silicormosia/EmeraldData.jl


## Credits
Please cite our paper(s) when you use EmeraldData:

- Y. Wang, P. Köhler, R. K. Braghiere, M. Longo, R. Doughty, A. A. Bloom, and C. Frankenberg. 2022.
  GriddingMachine, a database and software for Earth system modeling at global and regional scales.
  Scientific Data. 9: 258.
  [DOI](https://doi.org/10.1038/s41597-022-01346-x)


## About
[`EmeraldData.jl`][ed-url] includes a collection of global canopy propertie. To best utilize `Pkg.Artifacts` and FTP storage, [`EmeraldData.jl`][ed-url] only supports julia 1.7 and above.

| Documentation           | CI Status             | Compatibility           | Code Coverage           |
|:------------------------|:----------------------|:------------------------|:------------------------|
| [![][dev-img]][dev-url] | [![][st-img]][st-url] | [![][min-img]][min-url] | [![][cov-img]][cov-url] |


## API
EmeraldData has the following sub-modules, some of which are in development. The sub-modules are
| Sub-module  | Functionality                   | Ready to use |
|:------------|:--------------------------------|:-------------|
| Blender     | Regrid the gridded datasets     | Testing      |
| Collector   | Distribute the gridded datasets | v0.2         |
| Fetcher     | Download ungridded datasets     | Testing      |
| Indexer     | Read the gridded datasets       | v0.2         |
| Partitioner | Sort the ungridded datasets     | Testing      |
| Requestor   | Request gridded datasets        | v0.2         |

See [`API`][ed-api] for more detailed information about how to use [`EmeraldData.jl`][ed-url].


## Data contribution
We welcome the contribution of global scale datasets to `EmeraldData.jl`. To maximally promote data reuse, we ask data owners to preprocess your datasets before sharing with us, the requirements
    are:
- The dataset is stored in a NetCDF file
- The dataset is either a 2D or 3D array
- The dataset is cylindrically projected (WGS84 projection)
- The first dimension of the dataset is longitude
- The second dimension of the dataset is latitude
- The third dimension (if available) is the cycle index, e.g., time
- The longitude is oriented from west to east hemisphere (-180° to 180°)
- The latitude is oriented from south to north hemisphere (-90° to 90°)
- The dataset covers the entire globe (missing data allowed)
- Missing data is labeled as NaN (not a number) rather than an unrealistic fill value
- The dataset is not scaled (linearly, exponentially, or logarithmically)
- The dataset has common units, such as μmol m⁻² s⁻¹ for maximum carboxylation rate
- The spatial resolution is uniform longitudinally and latitudinally, e.g., both at 1/2°
- The spatial resolution is an integer division of 1°, such as 1/2°, 1/12°, 1/240°
- Each grid cell represents the average value of everything inside the grid cell area (as opposing to a single point in the middle of the cell)
- The label for the data is "data" (for conveniently loading the data)
- The label for the error is "std" (for conveniently loading the error)
- The dataset must contain one data array and one error array besides the dimensions
- The dataset contains citation information in the attributes
- The dataset contains a log summarizing changes if different from original source

The reprocessed NetCDF file should contain (only) the following fields:
| Field | Dimension | Description                           | Attributes   |
|:------|:----------|:--------------------------------------|:-------------|
| lon   | 1D        | Longitude in the center of a grid     | unit         |
|       |           |                                       | description  |
| lat   | 1D        | Latitude in the center of a grid      | unit         |
|       |           |                                       | description  |
| ind   | 1D        | Cycle index (for 3D data only)        | unit         |
|       |           |                                       | description  |
| data  | 2D/3D     | Data in the center of a grid          | longname     |
|       |           |                                       | unit         |
|       |           |                                       | about        |
|       |           |                                       | authors      |
|       |           |                                       | year         |
|       |           |                                       | title        |
|       |           |                                       | journal      |
|       |           |                                       | doi          |
|       |           |                                       | changeN      |
| std   | 2D/3D     | Error of data in the center of a grid | same as data |
|||||
