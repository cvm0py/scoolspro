import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(
        eventName: "Sports Day",
        eventDate: today.add(Duration(days: -42)),
        eventBackgroundColor: Colors.black),
    CalendarEvent(
        eventName: "Annual Day",
        eventDate: today.add(Duration(days: -30)),
        eventBackgroundColor: Colors.deepOrange),
    CalendarEvent(
        eventName: "Bank Holiday",
        eventDate: today.add(Duration(days: -5)),
        eventBackgroundColor: Colors.green),
    CalendarEvent(
        eventName: "Learn about history",
        eventDate: today.add(Duration(days: -6))),
    CalendarEvent(
        eventName: "School Trip", eventDate: today.add(Duration(days: -5))),
    CalendarEvent(
        eventName: "School Assembly",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: Colors.deepOrange),
    CalendarEvent(
        eventName: "Parents Teacher Meet",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: Colors.pink),
    CalendarEvent(
        eventName: "Class 12th Exam", eventDate: today.add(Duration(days: -4))),
    CalendarEvent(eventName: "Exam Schedule", eventDate: today),
    CalendarEvent(
        eventName: "Cultural Event",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Sports Event Class 1",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Badminton Challenge Juniors",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Table Tennis Meet InterSchool",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Ballet Dance Compitition",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Chess Logic Sports",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Classical Dance for Class 4-10",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Science Display Act",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Football Match For Secondary High School",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Cultural Event",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.lightBlueAccent),
    CalendarEvent(
        eventName: "Last date for fees",
        eventDate: today.add(Duration(days: 7)),
        eventBackgroundColor: Colors.red),
    CalendarEvent(
        eventName: "Teacher's Day", eventDate: today.add(Duration(days: 13))),
    CalendarEvent(
        eventName: "International Holiday",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: Colors.green),
    // CalendarEvent(
    //     eventName: "Buy new Play Station software",
    //     eventDate: today.add(Duration(days: 13)),
    //     eventBackgroundColor: Colors.indigoAccent),
    // CalendarEvent(
    //     eventName: "Update my flutter package",
    //     eventDate: today.add(Duration(days: 13))),
    // CalendarEvent(
    //     eventName: "Watch movies in my house",
    //     eventDate: today.add(Duration(days: 21))),
    // CalendarEvent(
    //     eventName: "Medical Checkup",
    //     eventDate: today.add(Duration(days: 30)),
    //     eventBackgroundColor: Colors.red),
    // CalendarEvent(
    //     eventName: "Gym",
    //     eventDate: today.add(Duration(days: 42)),
    //     eventBackgroundColor: Colors.indigoAccent),
  ];
  return sampleEvents;
}
