""" Update the database of EmeraldData.jl """
function update_database!()
    download_database!();
    global YAML_DATABASE, YAML_TAGS;
    (YAML_DATABASE, YAML_TAGS) = load_database!();

    return nothing
end;
