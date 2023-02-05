import YAML

function main()
    data = YAML.load_file("stack.yaml")
    raw_sections = []
    for section in data["stack"]
        section_name = section["section"]
        raw_blocks = []
        for block in section["blocks"]
            raw_lines = []
            for tech in block["tech"]
                icon = tech["icon"]
                name = tech["name"]
                star = tech["star"]
                line = """
$(' '^4)<img src="https://img.shields.io/static/v1?label=&logo=$icon&message=$name$(star ? " ★" : "")&labelColor=262A33&color=262A33">"""
                push!(raw_lines, line)
            end
            block = """
$(' '^2)<div>
$(join(raw_lines, '\n'))
$(' '^2)</div>"""
            push!(raw_blocks, block)
        end
        section = """
<div align="center">
$(' '^2)<h3>$section_name</h3>
$(join(raw_blocks, '\n'))
</div>"""
        push!(raw_sections, section)
    end
    result = join(raw_sections, "\n\n<br>\n\n")
    println(result)
end

main()
