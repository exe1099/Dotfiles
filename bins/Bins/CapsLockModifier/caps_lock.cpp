#include <iostream>
#include <fstream>
#include <vector>


int main () {

    std::string line;
    std::vector<std::string> original_content;

    // opening original file and checking if it works
    std::ifstream file_org("/usr/share/X11/xkb/symbols/pc");
    if (!file_org.good()) {
        std::cout << "Opening of the original file failed.\n";
        return 1;
    }

    // copying content of original file in vector
    while (std::getline(file_org, line)) {
        original_content.push_back(line);
    }
    file_org.close();
    std::cout << "Original file read.\n";

    // check if file has alrdy been modified
    for (auto line: original_content) {
        if (line.find("// modifier_map Lock") != std::string::npos) {
            std::cout << "File has already been modified.\n";
            std::cout << "Aborting program!\n";
            return 1;
        }
    }

    // opening backup file
    std::ofstream file_backup("/usr/share/X11/xkb/symbols/pc.backup");
    if (!file_backup.good()) {
        std::cout << "Opening of the backup file failed.\n";
        return 1;
    }

    // copying to backup file
    for (auto line: original_content) {
        file_backup << line << "\n";
    }
    file_backup.close();
    std::cout << "Content copied to backup file.\n";

    // opening original file to write modified content
    std::ofstream file_mod("/usr/share/X11/xkb/symbols/pc");
    if (!file_mod.good()) {
        std::cout << "Not able to write over original file.\n";
        return 1;
    }

    // copying modified content to original file
    for (auto line: original_content) {
        
        if (line.find("modifier_map Lock") != std::string::npos) {
            std::cout << "Line found in file and modified.\n";
            file_mod << "    // modifier_map Lock    { Caps_Lock };\n";
        }
        else {
        file_mod << line << "\n";
        }

    }
    file_mod.close();
    std::cout << "Modified file written.\n";
    std::cout << "Success!\n";

}
