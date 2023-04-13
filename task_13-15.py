from abc import ABC


# Задание 13
class Animals(ABC):
    def __init__(self):
        self._name = None
        self._commands = []
        self._birth_date = None

    def add_command(self, command):
        self._commands.append(command)

    def add_birth_date(self, birth_date):
        self._birth_date = birth_date

    def add_name(self, name):
        self._name = name

    def get_info(self):
        return f'Кличка: {self._name}, дата рождения: {self._birth_date}, список команд: {self._commands}'

    def get_name(self):
        return self._name


class Pets(Animals):
    pass


class PackAnimals(Animals):
    pass


class Dog(Pets):
    pass


class Cat(Pets):
    pass


class Hamster(Pets):
    pass


class Horse(PackAnimals):
    pass


class Camel(PackAnimals):
    pass


class Donkey(PackAnimals):
    pass


# Задание 14
class Nursery:
    __DATA = {
        'собака': Dog(),
        'кошка': Cat(),
        'хомяк': Hamster(),
        'лошадь': Horse(),
        'верблюд': Camel(),
        'осёл': Donkey()
    }
    __COMMANDS = ('Добавить питомца', 'Получить список питомцев', 'Обучить команде питомца',
                'Получить список команд питомца', 'Выход')
    animals = []

    def add_animal(self, animal):
        _animal = self._create_animal(animal)
        self.animals.append(_animal)
        return _animal

    def _create_animal(self, animal):
        _animal = animal.lower()
        if _animal not in self.__DATA:
            raise TypeError('Такого животного не существует')
        return self.__DATA.get(animal.lower())

    def get_nursery_command(self):
        return self.__COMMANDS

    def get_animals(self):
        _animals = [_animal.get_info() for _animal in self.animals]
        if len(_animals):
            return _animals
        raise TypeError('Животных в приюте нет!')

    def get_animal_by_name(self, name):
        for animal in self.animals:
            if animal.get_name() == name:
                return animal
        raise TypeError('Такого животного не существует')


# Задание 15
class Counter:
    count = 0

    def add(self):
        self.count += 1


# Основная программа
if __name__ == "__main__":
    nursery_services = Nursery()
    counter = Counter()
    print('Добро пожаловать в Приют!')
    while True:
        print('Список доступных команд:')
        print(*nursery_services.get_nursery_command(), sep='\n')
        answer = input('Выберите команду, которую хотите осуществить: ')

        if answer == nursery_services.get_nursery_command()[-1]:
            print('До свидания')
            break

        elif answer == nursery_services.get_nursery_command()[0]:
            animal = input('Укажите, какое животное вы хотите добавить: ').lower()
            try:
                _animal = nursery_services.add_animal(animal)
                animal_name = input('Укажите имя животного: ')
                _animal.add_name(animal_name)
                animal_birth_date = input('Укажите дату рождения животного: ')
                _animal.add_birth_date(animal_birth_date)
                is_command = input('Хотите ли добавить команды, да или нет? ')
                if is_command.lower() == 'да':
                    command = input('Введите команду: ')
                    _animal.add_command(command)
                    counter.add()  # Счётчик работает только, если все поля заполнены
                print('Питомец успешно добавлен!')
            except TypeError as err:
                print(err)

        elif answer == nursery_services.get_nursery_command()[1]:
            try:
                print(*nursery_services.get_animals(), sep='\n')
            except TypeError as err:
                print(err)

        elif answer == nursery_services.get_nursery_command()[2]:
            command = input('Введите команду: ')
            name = input('Введите имя желаемого питомца: ')
            try:
                _animal = nursery_services.get_animal_by_name(name)
                _animal.add_command(command)
                print('Команда успешно добавлена!')
            except TypeError as err:
                print(err)

        elif answer == nursery_services.get_nursery_command()[3]:
            name = input('Введите имя желаемого питомца: ')
            try:
                _animal = nursery_services.get_animal_by_name(name)
                print(_animal.get_info())
            except TypeError as err:
                print(err)

        else:
            print('Неверный ввод команды!')
