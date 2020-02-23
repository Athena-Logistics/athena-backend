# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Athena.Repo.insert!(%Athena.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Athena.Inventory

{:ok, event_aufgetischt} = create_event(%{name: "Aufgetischt SG 2020"})

{:ok, location_gallus_platz} = create_location(event_aufgetischt, %{name: "Gallusplatz"})
{:ok, location_gallus_strasse} = create_location(event_aufgetischt, %{name: "Gallusstrasse"})
{:ok, location_vadian_platz} = create_location(event_aufgetischt, %{name: "Vadianplatz"})
{:ok, location_multertor} = create_location(event_aufgetischt, %{name: "Multertor"})
{:ok, location_cocktail_caravan} = create_location(event_aufgetischt, %{name: "Cocktail Caravan"})

{:ok, item_group_beer} = create_item_group(event_aufgetischt, %{name: "Bier"})
{:ok, item_group_wine} = create_item_group(event_aufgetischt, %{name: "Wein"})
{:ok, item_group_cups} = create_item_group(event_aufgetischt, %{name: "Becher"})
{:ok, item_group_softdrinks} = create_item_group(event_aufgetischt, %{name: "Softdrinks"})
{:ok, item_group_other} = create_item_group(event_aufgetischt, %{name: "Diverses"})

{:ok, item_lager} = create_item(item_group_beer, %{name: "Lager", unit: "Fass"})
{:ok, item_kloesti} = create_item(item_group_beer, %{name: "Klösti", unit: "Fass"})
{:ok, item_prosecco} = create_item(item_group_wine, %{name: "Prosecco", unit: "6er Pack"})
{:ok, item_rotwein} = create_item(item_group_wine, %{name: "Rotwein", unit: "6er Pack"})
{:ok, item_weisswein} = create_item(item_group_wine, %{name: "Weisswein", unit: "6er Pack"})
{:ok, item_cola} = create_item(item_group_softdrinks, %{name: "Cola", unit: "24er Pack"})
{:ok, item_fanta} = create_item(item_group_softdrinks, %{name: "Fanta", unit: "24er Pack"})
{:ok, item_sprite} = create_item(item_group_softdrinks, %{name: "Sprite", unit: "24er Pack"})
{:ok, item_bierbecher} = create_item(item_group_cups, %{name: "Bierbecher", unit: "Kiste"})
{:ok, item_event_becher} = create_item(item_group_cups, %{name: "Eventbecher", unit: "Kiste"})
{:ok, item_weinkelch} = create_item(item_group_cups, %{name: "Weinkelch", unit: "Kiste"})
{:ok, item_leere_kiste} = create_item(item_group_cups, %{name: "Leer", unit: "Kiste"})

{:ok, item_dreckige_kiste} =
  create_item(item_group_cups, %{name: "Dreckig", unit: "Kiste", inverse: true})

{:ok, item_eis} = create_item(item_group_other, %{name: "Eis", unit: "Sack"})

beer_location_initial_supply = fn location ->
  {:ok, _} = create_movement(item_lager, %{destination_location_id: location.id, amount: 50})
  {:ok, _} = create_movement(item_kloesti, %{destination_location_id: location.id, amount: 50})
  {:ok, _} = create_movement(item_prosecco, %{destination_location_id: location.id, amount: 5})
  {:ok, _} = create_movement(item_rotwein, %{destination_location_id: location.id, amount: 5})
  {:ok, _} = create_movement(item_weisswein, %{destination_location_id: location.id, amount: 5})
  {:ok, _} = create_movement(item_cola, %{destination_location_id: location.id, amount: 20})
  {:ok, _} = create_movement(item_fanta, %{destination_location_id: location.id, amount: 20})
  {:ok, _} = create_movement(item_sprite, %{destination_location_id: location.id, amount: 20})
  {:ok, _} = create_movement(item_bierbecher, %{destination_location_id: location.id, amount: 5})
  {:ok, _} = create_movement(item_weinkelch, %{destination_location_id: location.id, amount: 5})
  {:ok, _} = create_movement(item_leere_kiste, %{destination_location_id: location.id, amount: 2})

  {:ok, _} =
    create_movement(item_dreckige_kiste, %{destination_location_id: location.id, amount: 0})
end

beer_location_initial_supply.(location_gallus_platz)
beer_location_initial_supply.(location_gallus_strasse)
beer_location_initial_supply.(location_vadian_platz)
beer_location_initial_supply.(location_multertor)

{:ok, _} =
  create_movement(item_event_becher, %{
    destination_location_id: location_cocktail_caravan.id,
    amount: 5
  })

{:ok, _} =
  create_movement(item_leere_kiste, %{
    destination_location_id: location_cocktail_caravan.id,
    amount: 1
  })

{:ok, _} =
  create_movement(item_dreckige_kiste, %{
    destination_location_id: location_cocktail_caravan.id,
    amount: 0
  })

{:ok, _} =
  create_movement(item_eis, %{destination_location_id: location_cocktail_caravan.id, amount: 2})
