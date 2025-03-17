local M = {}

function M.get()
	return {
		"#include <iostream>",
		"",
		"int main() {",
		'    std::cout << "Hello, world!" << std::endl;',
		"    return 0;",
		"}",
	}
end

return M
