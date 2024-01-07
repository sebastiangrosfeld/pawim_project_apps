# Projekt Lab PAWIM
Apps for PAWIM Project.

## Sprawozdanie

Link do aplikacji API: https://github.com/sebastiangrosfeld/pamiw_project_api

### Podpunkty zrealizowane
* Hosting API na Publicznym Serwerze (3 pkt)
* Kompatybilność Aplikacji Mobilnej (3 pkt)
* Udoskonalenie Interfejsu Aplikacji Mobilnej i Webowej (8 pkt)
* Opcje Logowania/Rejestracji [Google] (4 pkt)
* Dostęp do Zasobów Sprzętowych w aplikacji mobilnej (3 pkt)

### Podpunkty niezrealizowane
* Ustawienia Użytkownika (3 pkt)

### Podpunkty nieroztrzygnięte
* Warstwa Serwisów Dla Aplikacji Webowej i Mobilnej

Aplikacja mobilna i web-assembly (pwa) zostały rozbudowane o wymagane komponenty.
Logowanie Oauth2 dobywa się przy wykorzystaniu aplikacji w Konsoli Deweloperskiej Google,
należało tam założyć aplikację i ją skonfigurować, a następnie przekazać identyfikator klienta do aplikacji.
Zarówno baza danych jak i aplikacja zapewniająca API jest hostowana na usługach zapewnianych przez Microsoft Azure,
dzięki czemu nie było problemów z połączeniem tych elementów.

Aplikacja PWA została napisana w C# przy uzżyciu frameworka Blazor.
Aplikacja mobilna została napisana w języku Dart przy użyciu frameworka Flutter.
Aplikacja API została napisana w języku Java przy użyciu frameworka Spring Boot.
Baza danych to PostgreSQL.

Poniżej dokumentacja wizualna projektu.

Google API:
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/1d014508-eb03-4584-ad3e-7e296cbab0b3)

Aplikacja API hostowana na Azure:
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/c925f2c6-c64a-4e2e-ac83-f5365a08ee7d)

Baza danych:
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/7303b92f-1b5b-4f32-a5f7-8738583e328d)

![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/157f2f37-6727-4257-a7b9-c0cc72e369d9)

Dodanie Google Auth do aplikacji API:
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/b19b51e3-e1c4-4ccf-a1fd-46f88b8646f4)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/1939f3cc-19aa-4a1d-8cc2-01f262c4e519)

Aplikacja PWA:
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/b688d48d-9bd9-46c8-8e86-6a63ab5dea51)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/e839ff56-e083-4bc9-846f-0d5cd37d61aa)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/6d51a910-6f2e-4799-9260-6a388d9cbe80)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/8bfc7f87-1c19-4b0b-bf19-18a01bf359e8)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/52620b7e-b96b-4aa1-884d-f3b1de899bdf)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/ee9d2bc1-01cd-4ad3-95ce-d0ba06a9b9cc)

Aplikacja mobilna:
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/6e618ad8-0ae2-49d7-ba56-c87fab85b829)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/9af05343-32b8-477c-9eeb-f22b7dbd8e3b)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/aeb60a52-a8a8-4c5f-9483-0b27c01e7a1d)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/0dce1603-d49d-4aa0-bade-ed090252718d)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/80757e05-7134-422a-9696-54c7785d3994)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/583a096d-0f2d-438d-9d63-faa92e64a4a9)
![image](https://github.com/sebastiangrosfeld/pawim_project_apps/assets/95347931/69c67861-d8ad-4383-b47c-a5362f746435)





