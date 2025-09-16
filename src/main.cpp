#include <iostream>
#include <string>
#include <cmath>

#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>

#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SFML-Graphics.hpp>

/////////////////////

using namespace std;
using namespace tgui;
using namespace sf;

/////////////////////


// variables
static short score_pl1_short = 0, score_pl2_short = 0, number_cube1_pl1, number_cube2_pl1, number_cube1_pl2, number_cube2_pl2;
static string pl1_name = "pl1", pl2_name = "pl2";


void game();

// main func
int main() {
    game();
}

void game()
{
    RenderWindow window{VideoMode{ {1024, 512} }, "Drop it or Die"};
    Gui gui{window};

    string text_label = "Score: ";

    auto score_pl1_text = tgui::Label::create();
    string full_text_pl1_score = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
    score_pl1_text->setText(full_text_pl1_score);

    score_pl1_text->getRenderer()->setTextColor(tgui::Color::White);
    score_pl1_text->getRenderer()->setFont("./fonts/Hero-Bold.ttf");
    score_pl1_text->setPosition("2%", "2%");
    score_pl1_text->setTextSize(16);
    score_pl1_text->setOrigin(0, 0);
    gui.add(score_pl1_text);

    auto score_pl2_text = tgui::Label::create("Score: 0");
    string full_text_pl2_score = "(" + pl2_name + ") score: " + to_string(score_pl2_short);
    score_pl2_text->setText(full_text_pl2_score);

    score_pl2_text->getRenderer()->setTextColor(tgui::Color::White);
    score_pl2_text->getRenderer()->setFont("./fonts/Hero-Bold.ttf");
    score_pl2_text->setPosition("98%", "2%");
    score_pl2_text->setTextSize(16);
    score_pl2_text->setOrigin(1, 0);
    gui.add(score_pl2_text);

    auto btn_tap = Button::create("Click me!");
    btn_tap->getRenderer()->setTextColor({199, 199, 199});
    btn_tap->getRenderer()->setFont("./fonts/Hero-Bold.ttf");
    btn_tap->getRenderer()->setBackgroundColor({0, 0, 0, 130});
    btn_tap->getRenderer()->setBorderColorFocused({0, 0, 0});
    btn_tap->setSize(150, 100);
    btn_tap->setTextSize(28);
    btn_tap->setPosition("50%", "50%");
    btn_tap->setOrigin(0.5, 0.5);
    btn_tap->onPress([&]{
        score_pl1_short++;
        string full_text;
        full_text = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
        score_pl1_text->setText(full_text);
    });
    gui.add(btn_tap);

    while (window.isOpen())
    {
        while (const std::optional event = window.pollEvent()) {
            gui.handleEvent(*event);
            
            if (event->is<sf::Event::Closed>())
                window.close();
        }

        // render
        window.clear({62, 35, 0});
        gui.draw();
        window.display();
    }
}