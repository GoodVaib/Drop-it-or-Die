#include <iostream>
#include <string>
#include <cmath>
#include <cstdlib>
#include <ctime>

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
    srand(time(NULL));
    game();
}

void game()
{
    RenderWindow window{VideoMode{ {1024, 512} }, "Drop it or Die"};
    window.setFramerateLimit(60);
    Gui gui{window};

    auto theme = tgui::Theme::create("./themes/theme.txt");

    // pl1 score
    auto score_pl1_text = tgui::Label::create(); gui.add(score_pl1_text);
    string full_text_pl1_score = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
    score_pl1_text->setText(full_text_pl1_score);

    score_pl1_text->getRenderer()->setTextColor(tgui::Color::White);
    score_pl1_text->getRenderer()->setFont("./fonts/Hero-Bold.ttf");
    score_pl1_text->setPosition("1%", "2%");
    score_pl1_text->setTextSize(16);
    score_pl1_text->setOrigin(0, 0);

    // pl2 score
    auto score_pl2_text = tgui::Label::create("Score: 0"); gui.add(score_pl2_text);
    string full_text_pl2_score = "(" + pl2_name + ") score: " + to_string(score_pl2_short);
    score_pl2_text->setText(full_text_pl2_score);

    score_pl2_text->getRenderer()->setTextColor(tgui::Color::White); 
    score_pl2_text->getRenderer()->setFont("./fonts/Hero-Bold.ttf");
    score_pl2_text->setPosition("99%", "2%");
    score_pl2_text->setTextSize(16);
    score_pl2_text->setOrigin(1, 0);

    // start button
    auto start_btn = Button::create(); gui.add(start_btn);
    start_btn->setSize(121, 42);
    start_btn->setTextSize(31);
    start_btn->setOrigin(0.5, 0.5);
    start_btn->setPosition("50%", "50%"); // center window - origin (0.5,0.5)

    start_btn->onPress([&]{
        score_pl1_short++;
        string full_text;
        full_text = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
        score_pl1_text->setText(full_text);
    });


    // menu button
    auto btn_tap = Button::create("Menu"); gui.add(btn_tap);
    btn_tap->setRenderer(theme->getRenderer("gd_button"));
    btn_tap->setSize(121, 42);
    btn_tap->setTextSize(31);
    btn_tap->setOrigin(0, 1);
    btn_tap->setPosition("1%", "98%"); // left-down = origin (0,1)
    btn_tap->setIgnoreMouseEvents(true);
    
    btn_tap->onPress([&]{
        score_pl1_short++;
        string full_text;
        full_text = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
        score_pl1_text->setText(full_text);
    });
    


    
    
    while (window.isOpen())
    {
        while (const std::optional event = window.pollEvent()) {
            gui.handleEvent(*event);
            
            // quit - close window
            if (event->is<sf::Event::Closed>())
                window.close();
        }

        // render
        window.clear({62, 35, 0});
        gui.draw();
        window.display();
    }
}