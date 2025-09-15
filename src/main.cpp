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

int main()
{
    RenderWindow window{VideoMode{ {800, 600} }, "Drop it or Die"};
    Gui gui{window};
    
     
    auto score_pl1_text = tgui::Label::create("Score: 0");
    score_pl1_text->setPosition("2%", "2%");
    score_pl1_text->setTextSize(18);
    score_pl1_text->setOrigin(0, 0);
    gui.add(score_pl1_text);

    auto score_pl2_text = tgui::Label::create("Score: 0");
    score_pl2_text->setPosition("98%", "2%");
    score_pl2_text->setTextSize(18);
    score_pl2_text->setOrigin(1, 0);
    gui.add(score_pl2_text);

    auto btn_tap = Button::create("Click me!");
    btn_tap->setPosition("50%", "50%");
    btn_tap->setOrigin(0.5, 0.5);
    btn_tap->onPress([&]{
        static long score = 0;
        score++;
        std::string text_label = "Score: ";
        text_label += std::to_string(score);
        score_pl1_text->setText(text_label);
    });
    gui.add(btn_tap);

    while (window.isOpen())
    {
        while (const std::optional event = window.pollEvent()) {
            gui.handleEvent(*event);
            
            //window.close();
            if (event->is<sf::Event::Closed>())
                window.close();
        }

        window.clear({62, 35, 0});
        gui.draw();
        window.display();
    }
}