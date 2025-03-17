local M = {}

function M.get()
	return {
		"#include <QApplication>",
		"#include <QWidget>",
		"",
		"int main(int argc, char *argv[]) {",
		"    QApplication app(argc, argv);",
		"",
		"    QWidget window;",
		"    window.resize(320, 240);",
		'    window.setWindowTitle("Qt Window");',
		"    window.show();",
		"",
		"    return app.exec();",
		"}",
	}
end

return M
